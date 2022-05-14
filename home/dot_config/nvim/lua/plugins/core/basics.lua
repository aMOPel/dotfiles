local configs = {}

configs['indent_blankline.nvim'] = function()
  -- vim.g.indent_blankline_use_treesitter = true
  -- vim.g.indent_blankline_show_current_context = true
  require("indent_blankline").setup {
    char = "|",
    buftype_exclude = { "terminal", "help", "clap_input", "floaterm", "wilder", "lsp-installer" }
  }
end

configs['vim-matchup'] = function()
  -- vim.g.matchup_surround_enabled = 1
  -- vim.g.matchup_transmute_enabled = 1
  vim.g.matchup_text_obj_enabled = 0
  vim.g.matchup_matchparen_offscreen = { method = 'popup' }
end

configs['vim-cutlass'] = function()
  local noremap = require 'utils'.noremap
  noremap('n', 'm', 'd')
  noremap('x', 'm', 'd')
  noremap('n', 'mm', 'dd')
  noremap('n', 'M', 'D')
end

configs['FixCursorHold.nvim'] = function()
  vim.g.cursorhold_updatetime = 100
end

configs['vim-cool'] = function()
  vim.g.CoolTotalMatches = 1
end

configs['vim-asterisk'] = function()
  local map = require 'utils'.map
  map('', '*', '<Plug>(asterisk-gz*)')
  vim.g['asterisk#keeppos'] = 1
end

configs['vim-togglelist'] = function()
  vim.g.toggle_list_no_mappings = 1
  local map = require 'utils'.map
  map('n', '<c-w>q', ':call ToggleQuickfixList()<cr>')
  map('n', '<c-w><c-q>', ':call ToggleQuickfixList()<cr>')
  -- for vim-dispatch
  if vim.g.loaded_dispatch == 1 then
    vim.g.toggle_list_copen_command = "Copen"
  end
end

configs['errormarker.vim'] = function()
  vim.g.errormarker_errortext = ""
  vim.g.errormarker_warningtext = ""
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/lukas-reineke/indent-blankline.nvim',
    config = configs['indent_blankline.nvim']
  }
  use {
    p 'https://github.com/andymass/vim-matchup',
    config = configs['vim-matchup']
  }
  use {
    p 'https://github.com/svermeulen/vim-cutlass',
    config = configs['vim-cutlass']
  }
  use {
    p 'https://github.com/antoinemadec/FixCursorHold.nvim',
    config = configs['FixCursorHold.nvim']
  }
  use {
    p 'https://github.com/romainl/vim-cool',
    config = configs['vim-cool'],
  }
  use {
    p 'https://github.com/haya14busa/vim-asterisk',
    config = configs['vim-asterisk']
  }
  use {
    p 'https://github.com/milkypostman/vim-togglelist',
    config = configs['vim-togglelist']
  }
  use {
    p 'https://github.com/mh21/errormarker.vim',
    config = configs['errormarker.vim'],
  }
  use { p 'https://github.com/tpope/vim-unimpaired', }
  use { p 'https://github.com/tpope/vim-obsession', }
  use { p 'https://github.com/deris/vim-shot-f', }

end
return M
