# dotfiles

Personal dotfiles managed with **Ansible** — idempotent, tag-selectable, and runnable against both the local machine and remote hosts via SSH.

Targets **Ubuntu 22.04+**.

---

## Components

| Tag | What gets installed |
|-----|---------------------|
| `git` | git, [delta](https://github.com/dandavison/delta) (diff pager), [lazygit](https://github.com/jesseduffield/lazygit) |
| `nvim` | [Neovim](https://neovim.io/) ≥ 0.10 via PPA → AppImage fallback |
| `tmux` | tmux, [TPM](https://github.com/tmux-plugins/tpm) |
| `vim` | vim-gtk3, [dein.vim](https://github.com/Shougo/dein.vim) |
| `yazi` | rustup, [Yazi](https://github.com/sxyazi/yazi) (cargo), zoxide, fd-find, nightfly flavor, lazygit plugin |
| `zsh` | zsh, [prezto](https://github.com/sorin-ionescu/prezto), fzf integration |
| `fzf` | [fzf](https://github.com/junegunn/fzf), bat, tree, ripgrep *(auto-installed as a dependency of zsh)* |
| `fonts` | [Hack Nerd Font](https://www.nerdfonts.com/) *(auto-installed as a dependency of git / nvim / tmux / yazi)* |
| `powerline` | [powerline](https://github.com/powerline/powerline) *(auto-installed as a dependency of zsh / vim / nvim / tmux)* |

### Install method priority

Each tool is installed using the highest-priority method that satisfies the minimum version requirement:

1. **apt** — default Ubuntu repository
2. **apt + PPA** — e.g. `ppa:neovim-ppa/unstable`
3. **Binary download** — GitHub Releases `.deb` or archive
4. **AppImage** — with FUSE detection (run directly if available, extract otherwise)
5. **Build from source** — `cargo install` / `go build`

---

## Quick start

### Local install

Clone the repository and run the installer:

```sh
git clone https://github.com/shift-crops/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

Install only specific components:

```sh
./install.sh -t git,nvim       # git + neovim
./install.sh -t zsh            # zsh (also installs fzf and powerline)
```

### Remote install via SSH

The dotfiles repository must be cloned on the remote host first, then run:

```sh
# Install everything on a remote host (SSH key authentication)
./install.sh -H user@192.168.1.10

# Install specific components on a remote host
./install.sh -H user@host -t nvim,tmux

# Use password authentication instead of SSH key
./install.sh -H user@host -k

# Dotfiles cloned to a non-default path on the remote
./install.sh -H user@host -r /opt/dotfiles
```

> The installer automatically syncs the local dotfiles to the remote host via `rsync` (`.git/` excluded) before running Ansible. No manual transfer is needed.
> The remote dotfiles path defaults to `~/dotfiles`. Override with `-r` if needed.

---

## Options

```
Usage: install.sh [OPTIONS]

  -t, --tags TAGS         Install only the specified components (comma-separated)
  -H, --host HOST         Apply to a remote host via SSH (user@host format)
  -r, --remote-dir DIR    Path to dotfiles on the remote host (default: ~/dotfiles)
  -k, --ask-pass          Prompt for SSH password
  -l, --list-tags         List all available tags and exit
  -h, --help              Show this help and exit
```

---

## Directory structure

```
dotfiles/
├── install.sh          # entry point
├── site.yml            # Ansible playbook
├── ansible.cfg         # roles_path = .:deps
├── inventory           # localhost (ansible_connection=local)
├── group_vars/
│   └── all.yml         # XDG paths, minimum versions, cargo_bin
├── toolchains/         # shared role — Go, Rust and Node toolchains
│   └── tasks/
│       ├── go.yml
│       ├── rust.yml
│       └── node.yml
├── git/                # role: git + delta + lazygit
│   ├── tasks/main.yml
│   └── configs/        # symlinked to ~/.config/git/
│       └── lazygit/    # symlinked to ~/.config/lazygit/
├── nvim/               # role: neovim
│   ├── tasks/main.yml
│   └── configs/        # symlinked to ~/.config/nvim/
├── tmux/               # role: tmux + tpm
│   ├── tasks/main.yml
│   └── configs/        # symlinked to ~/.config/tmux/
├── vim/                # role: vim + dein.vim
│   ├── tasks/main.yml
│   └── configs/        # symlinked to ~/.vim/
├── yazi/               # role: yazi
│   ├── tasks/main.yml
│   └── configs/        # symlinked to ~/.config/yazi/
├── zsh/                # role: zsh + prezto
│   ├── tasks/main.yml
│   └── configs/        # .zshenv → $HOME; others → $ZDOTDIR with leading dot
└── deps/
    ├── fonts/          # role: Hack Nerd Font
    ├── fzf/            # role: fzf + bat + tree + ripgrep
    ├── powerline/      # role: powerline
    └── tree-sitter/    # role: tree-sitter
```

Config files under each `configs/` directory are **automatically symlinked** — no manual listing required.
