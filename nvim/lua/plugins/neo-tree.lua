return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
		window = {
			width = 30,
			mappings = {
				["g"] = "open_lazygit",
			},
		},
		commands = {
			-- 選択中のパスでLazyGitを開く
			open_lazygit = function(state)
				local node = state.tree:get_node()  -- 選択中のノード取得
				local path = node:get_id()          -- ノードのパス取得
				-- vim.cmd('tabnew | terminal lazygit -p ' .. path)  -- 新タブでLazyGit起動
				-- vim.cmd('startinsert')
				_lazygit_toggle_dir(path)
			end,
		},
	},
	config = function(_, opts)
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>",{ noremap = true })
		require("neo-tree").setup(opts)
	end
}
