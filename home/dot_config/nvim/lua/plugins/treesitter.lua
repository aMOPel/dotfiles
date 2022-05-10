local configs = {}

configs['nvim-treesitter'] = function()
-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- parser_configs.norg = {
--     install_info = {
--         url = "https://github.com/nvim-neorg/tree-sitter-norg",
--         files = { "src/parser.c", "src/scanner.cc" },
--         branch = "main"
--     },
-- }

-- parser_configs.http = {
--   install_info = {
--     url = "https://github.com/NTBBloodbath/tree-sitter-http",
--     files = { "src/parser.c" },
--     branch = "main",
--   },
-- }

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    -- "viml",
    -- "http",
    -- "norg",
    -- "latex",

    "html",
    "css",
    "javascript",
    "typescript",
    "vue",

    "gdscript",
    "godot_resource",

    "python",

    "lua",

    "cpp",
    "cmake",

    "json",
    "toml",
    "yaml",

    "bash",
    "regex",
    "comment",
    "dockerfile",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = false,
    disable = {
      "gdscript",
      "python",
    }
  },
  context_commentstring = {
    enable = true,
    config = {
      vim = '" %s',
      lua = '-- %s',
      toml = '# %s',
    }
  },
  matchup = {
    enable = true,
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart',
    }
  },
--  element_textobject = {
--    enable = true,
--    set_jumps = true,
--    keymaps = {
--      ['ga'] = 'goto_next_element',
--      ['gA'] = 'goto_prev_element',
--      [']a'] = 'swap_next_element',
--      ['[a'] = 'swap_prev_element',
--      ['ia'] = 'inner_element',
--      ['aa'] = 'an_element',
--    }
--  },
--  scope_textobject = {
--    enable = true,
--    set_jumps = true,
--    keymaps = {
--      ['go'] = 'incremental_outer_scope',
--      [']o'] = 'goto_next_scope',
--      ['[o'] = 'goto_prev_scope',
--      ['ao'] = 'a_scope',
--      ['io'] = 'a_scope',
--    }
--  },
}
end

local p = require'utils'.p

local M = function(use)
  use {
    p'nvim-treesitter/nvim-treesitter',
    requires = {
      { p'https://github.com/JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter', },
      { p'https://github.com/RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter', },
      { p'https://github.com/romgrk/nvim-treesitter-context', after = 'nvim-treesitter', },
      -- { p'https://github.com/jasonmchan/ts-textobjects', after = 'nvim-treesitter', },
    },
    config = configs['nvim-treesitter'],
    run = ':TSUpdate',
    event = { 'BufRead' },
  }
end
return M
