return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			theme = 'powerline',
			icons_enabled = true,
			always_show_tabline = true,
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {'fileformat', 'encoding', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'selectioncount', 'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {
			lualine_a = {
				{
					'buffers',
					buffers_color = switch_color,
					symbols = { modified = ' 󰷥', alternate_file = ' ', directory = ' ' },
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{ 'tabs', tabs_color = switch_color },
			},
		},
	},
}
