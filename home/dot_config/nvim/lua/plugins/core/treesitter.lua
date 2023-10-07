local plugins = require 'globals'.plugins

table.insert(plugins, {
  name = 'nvim-treesitter',
  setup = function()
  end,
  config = function()
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

    local g = require 'globals'
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = g.treesitter.ensure_installed,
      highlight = {
        enable = true,
        disable = g.treesitter.highlight.disable,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
        disable = g.treesitter.indent.disable,
      },
      incremental_selection = {
        enable = false,
        disable = g.treesitter.incremental_selection.disable,
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
  end,
})

table.insert(plugins, {
  name = 'nvim-treesitter-context',
  setup = function()
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context()
    end, { silent = true })
  end,
  config = function()
    require'treesitter-context'.setup{
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 10000, -- The Z-index of the context window
      on_attach = function ()
        vim.cmd[[hi TreesitterContextBottom gui=underline guisp=Grey]]
      end
    }
  end,
})

local p = require 'utils'.p

local M = function(use)
  use {
    p 'nvim-treesitter/nvim-treesitter',
    requires = {
      { p 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter', },
      { p 'https://github.com/RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter', },
      -- { p'https://github.com/jasonmchan/ts-textobjects', after = 'nvim-treesitter', },
      { p 'https://github.com/nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter', },
    },
    run = ':TSUpdate',
  }
end
return M
