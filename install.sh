#!/bin/bash
set -euo pipefail

cd $(dirname $0)
DOTFILES_DIR="$(pwd)"

# ── bootstrap ansible ────────────────────────────────────────────────────────
if ! command -v ansible-playbook &>/dev/null; then
    echo "[install] ansible-playbook not found — installing via apt..."
    sudo apt-get update -qq
    sudo apt-get install -y ansible
fi

# ── argument handling ────────────────────────────────────────────────────────
usage() {
    cat <<'EOF'
Usage: install.sh [OPTIONS]

OPTIONS:
  -t, --tags TAGS         Install only the specified components (comma-separated)
  -H, --host HOST         Apply to a remote host via SSH (user@host format)
  -r, --remote-dir DIR    Path to dotfiles on the remote host (default: ~/dotfiles)
  -k, --ask-pass          Prompt for SSH password (when SSH key is not configured)
  -l, --list-tags         List all available component tags and exit
  -h, --help              Show this help message and exit

COMPONENTS:
  git        git + lazygit (go build with patch) + delta
  nvim       neovim  (ppa:neovim-ppa/unstable → AppImage fallback)
  tmux       tmux + tpm
  vim        vim-gtk3 + dein.vim
  yazi       rustup + yazi (cargo) + zoxide + fd-find
  zsh        zsh + prezto
  fonts      Hack Nerd Font  (auto-installed as dep of git/nvim/tmux/yazi)
  fzf        fzf + bat + tree + rg  (auto-installed as dep of zsh)
  powerline  powerline  (auto-installed as dep of zsh/vim/nvim/tmux)

EXAMPLES:
  ./install.sh                          # install everything locally
  ./install.sh -t git,nvim              # install git and neovim locally
  ./install.sh -H user@192.168.1.10    # install everything on a remote host
  ./install.sh -H user@host -t zsh     # install zsh on a remote host
  ./install.sh -H user@host -k         # remote host, prompt for SSH password
  ./install.sh -H user@host -r /opt/dotfiles   # dotfiles at custom remote path

REMOTE NOTES:
  The dotfiles repository must already be cloned on the remote host.
  The remote path defaults to ~/dotfiles; override with -r if needed.
  SSH key-based authentication is assumed; use -k to prompt for a password.
EOF
}

EXTRA_ARGS=()
HOST=""
REMOTE_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--tags)
            EXTRA_ARGS+=(--tags "$2")
            shift 2
            ;;
        -H|--host)
            HOST="$2"
            shift 2
            ;;
        -r|--remote-dir)
            REMOTE_DIR="$2"
            shift 2
            ;;
        -k|--ask-pass)
            EXTRA_ARGS+=(--ask-pass)
            shift
            ;;
        -l|--list-tags)
            ansible-playbook "$DOTFILES_DIR/site.yml" --list-tags
            exit 0
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

# ── inventory & dotfiles_dir ─────────────────────────────────────────────────
if [[ -n "$HOST" ]]; then
    # Remote mode: build a temporary inventory for the target host
    TMP_INV=$(mktemp)
    trap 'rm -f "$TMP_INV"' EXIT INT TERM

    printf '%s ansible_python_interpreter=/usr/bin/python3\n' "$HOST" > "$TMP_INV"

    # Default remote dotfiles path: ~/dotfiles (tilde expanded on the remote shell)
    [[ -z "$REMOTE_DIR" ]] && REMOTE_DIR='~/dotfiles'

    echo "[install] syncing dotfiles to ${HOST}:${REMOTE_DIR} ..."
    rsync -az --delete --exclude='.git' "$DOTFILES_DIR/" "${HOST}:${REMOTE_DIR}/"

    ansible-playbook "$DOTFILES_DIR/site.yml" \
        -i "$TMP_INV" \
        -e "dotfiles_dir=${REMOTE_DIR}" \
        "${EXTRA_ARGS[@]}" \
        --ask-become-pass -v
else
    # Local mode: use the bundled inventory (localhost with ansible_connection=local)
    exec ansible-playbook "$DOTFILES_DIR/site.yml" \
        "${EXTRA_ARGS[@]}" \
        --ask-become-pass -v
fi
