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
		custom_linter = {},
	},
	formatter = {
		ensure_installed = {},
		filetype = {},
		on_save = {},
	},
  dap = {
		ensure_installed = {},
		filetype = {},
  },
	recipes = {
		global = {},
	},
}

return M
