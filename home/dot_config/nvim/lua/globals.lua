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

			"gitignore",
			"gitattributes",
			"gitcommit",
			"git_config",
			"git_rebase",
			"diff",

			"gpg",
			"ini",
			"make",
      "rst",
      "csv",
      "ssh_config",

			"vimdoc",
      "sql",
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
}

return M
