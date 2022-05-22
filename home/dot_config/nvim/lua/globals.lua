local M = {
  plugin = {
    configs = {},
    setups = {},
  },
  lsp = {
    fts = {
    },
    servers = {
      lsp_installer = {
      },
      other = {
      },
    },
  },
  treesitter = {
    ensure_installed = {
      -- 'viml',
      -- 'http',
      -- 'norg',

      'regex',
      'comment',
    },
    highlight = {
      disable = {}
    },
    incremental_selection = {
      disable = {}
    },
    indent = {
      disable = {}
    },
  },
}

return M

