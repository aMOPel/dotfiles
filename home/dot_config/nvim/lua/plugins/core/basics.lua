local plugins = require 'globals'.plugins

table.insert(plugins, {
  name = 'indent_blankline.nvim',
  setup = function()
  end,
  config = function()
    -- vim.g.indent_blankline_use_treesitter = true
    -- vim.g.indent_blankline_show_current_context = true
    require('indent_blankline').setup {
      char = '|',
      buftype_exclude = { 'terminal', 'help', 'floaterm', 'lsp-installer', 'qf' }
    }
  end,
})

table.insert(plugins, {
  name = 'vim-matchup',
  setup = function()
  end,
  config = function()
    -- vim.g.matchup_surround_enabled = 1
    -- vim.g.matchup_transmute_enabled = 1
    vim.g.matchup_text_obj_enabled = 0
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  end,
})

table.insert(plugins, {
  name = 'vim-cutlass',
  setup = function()
  end,
  config = function()
    local noremap = require 'utils'.noremap
    noremap('n', 'm', 'd')
    noremap('x', 'm', 'd')
    noremap('n', 'mm', 'dd')
    noremap('n', 'M', 'D')
  end,
})

table.insert(plugins, {
  name = 'FixCursorHold.nvim',
  setup = function()
  end,
  config = function()
    vim.g.cursorhold_updatetime = 100
  end,
})

table.insert(plugins, {
  name = 'vim-cool',
  setup = function()
  end,
  config = function()
    vim.g.CoolTotalMatches = 1
  end,
})

table.insert(plugins, {
  name = 'vim-asterisk',
  setup = function()
  end,
  config = function()
    local map = require 'utils'.map
    map('', '*', '<Plug>(asterisk-gz*)')
    vim.g['asterisk#keeppos'] = 1
  end,
})

table.insert(plugins, {
  name = 'vim-togglelist',
  setup = function()
  end,
  config = function()
    vim.g.toggle_list_no_mappings = 1
    local map = require 'utils'.map
    map('n', '<c-w>q', ':call ToggleQuickfixList()<cr>')
    map('n', '<c-w><c-q>', ':call ToggleQuickfixList()<cr>')
    -- for vim-dispatch
    if vim.g.loaded_dispatch == 1 then
      vim.g.toggle_list_copen_command = "Copen"
    end
  end,
})

table.insert(plugins, {
  name = 'errormarker.vim',
  setup = function()
  end,
  config = function()
    vim.g.errormarker_errortext = ""
    vim.g.errormarker_warningtext = ""
  end,
})

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/lukas-reineke/indent-blankline.nvim', }
  use { p 'https://github.com/andymass/vim-matchup', }
  use { p 'https://github.com/svermeulen/vim-cutlass', }
  use { p 'https://github.com/antoinemadec/FixCursorHold.nvim', }
  use { p 'https://github.com/romainl/vim-cool', }
  use { p 'https://github.com/haya14busa/vim-asterisk', }
  use { p 'https://github.com/milkypostman/vim-togglelist', }
  use { p 'https://github.com/mh21/errormarker.vim', }
  use { p 'https://github.com/tpope/vim-unimpaired', }
  use { p 'https://github.com/tpope/vim-obsession', }
  use { p 'https://github.com/deris/vim-shot-f', }
end
return M
