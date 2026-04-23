return {
	'akinsho/toggleterm.nvim',
	version = "*",
	lazy = true,
	opts = {
		--[[ things you want to change go here]]
	},
	init = function()
		local Terminal  = require('toggleterm.terminal').Terminal

		function _lazygit_toggle()
			local lazygit = Terminal:new({
				cmd = "lazygit",
				direction = "float",
				hidden = true
			})
			lazygit:toggle()
		end

		function _lazygit_toggle_dir(path)
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = path,
				direction = "float",
				hidden = true
			})
			lazygit:toggle()
		end

		-- vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
	end,
}
