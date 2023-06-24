local M = {
	plugins = {
		-- { name = '', config = '', setup = '' }
	},
	lsp = {
		fts = {},
		servers = {
			lsp_installer = {},
			special_setup = {},
			other = {},
		},
	},
	treesitter = {
		ensure_installed = {
			-- 'viml',
			"http",
			-- 'norg',

			"vimdoc",
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
	linter = {
		ensure_installed = {},
		filetype = {},
	},
	formatter = {
		ensure_installed = {},
		filetype = {},
		on_save = {},
	},
	recipes = {
		global = {},
	},
}

return M
