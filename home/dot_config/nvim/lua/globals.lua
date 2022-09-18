local M = {
	plugins = {
		-- { name = '', config = '', setup = '' }
	},
	lsp = {
		fts = {},
		servers = {
			lsp_installer = {},
			other = {},
		},
	},
	treesitter = {
		ensure_installed = {
			-- 'viml',
			-- 'http',
			-- 'norg',

			"regex",
			"comment",
		},
		highlight = {
			disable = {},
		},
		incremental_selection = {
			disable = {},
		},
		indent = {
			disable = {},
		},
	},
	formatter = {
		ensure_installed = {},
		filetype = {},
		on_save = {},
	},
}

return M
