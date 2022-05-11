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

configs['rnvimr'] = function()
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_enable_picker = 0
  vim.g.rnvimr_enable_bw = 1
  vim.g.rnvimr_draw_border = 0
  vim.cmd [[
let g:rnvimr_layout = {
  \ 'relative': 'editor',
  \ 'width': float2nr(round(0.9 * &columns)),
  \ 'height': float2nr(round(0.8 * &lines)),
  \ 'col': float2nr(round(0.05 * &columns)),
  \ 'row': float2nr(round(0.05 * &lines)),
  \ 'style': 'minimal',
  \ 'border': 'rounded',
  \ }
]]

  local noremap = require 'utils'.noremap
  noremap('n', '<leader>rr', ':RnvimrToggle<CR>')
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
    p 'https://github.com/kevinhwang91/rnvimr',
    config = configs['rnvimr']
  }
  use {
    p 'https://github.com/svermeulen/vim-cutlass',
    config = configs['vim-cutlass']
  }
  use { p 'https://github.com/tpope/vim-unimpaired', }
  use { p 'https://github.com/tpope/vim-obsession', }
  use {
    p 'https://github.com/antoinemadec/FixCursorHold.nvim',
    config = configs['FixCursorHold.nvim']
  }
  use { p 'https://github.com/junegunn/vim-slash', }
end
return M
