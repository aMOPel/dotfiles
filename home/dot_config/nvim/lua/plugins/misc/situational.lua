local configs = {}
local setups = {}

setups['vim-floaterm'] = function()
  vim.g.floaterm_shell = 'zsh'
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.8

  local noremap = require 'utils'.noremap
  noremap('n', '<leader>ff', ':FloatermToggle<CR>')
  noremap('t', '<C-W>', '<C-\\><C-n>:FloatermToggle<CR>')
  noremap('n', '<leader>fg', ':FloatermNew --autoclose=2 --disposable gitui<CR>')
  noremap('n', '<leader>ft', ':FloatermNew --autoclose=2 --disposable taskwarrior-tui<CR>')
  noremap('n', '<leader>fw', ':FloatermNew --autoclose=0 --disposable --width=0.9 timew week<CR>')
end

setups['vim-grepper'] = function()
  local noremap = require 'utils'.noremap
  local map = require 'utils'.map
  noremap('n', '<leader>gr', ':Grepper -tool rg -grepprg rg -H --no-heading --vimgrep --smart-case --<CR>')
  noremap('n', '<leader>*', ':Grepper -tool rg -cword -noprompt -grepprg rg -H --no-heading --vimgrep --smart-case --<cr>')

  map('n', 'gr', '<Plug>(GrepperOperator)')
  map('x', 'gr', '<Plug>(GrepperOperator)')

  vim.cmd([[
aug Grepper
  au!
  au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})
aug END
]] )

  vim.g.grepper = {
    open = 1,
    prompt_quote = 1,
    simple_prompt = 1,
    switch = 1,
    quickfix = 1,
    searchreg = 1,
    highlight = 1,
    dir = 'cwd',
    tools = { 'rg' },
    operator = {
      open = 1,
      switch = 1,
      prompt = 0,
      quickfix = 1,
      searchreg = 1,
      highlight = 1,
      dir = 'cwd',
      tools = { 'rg' },
    },
  }
end

setups['vim-fugitive'] = function()
  local noremap = require 'utils'.noremap
  noremap('n', '<leader>gg', ':-tabnew<cr>:Git ++curwin<CR>')
  noremap('n', '<leader>gl', ':-tabnew<cr>:Gclog <CR>')
  noremap('n', '<leader>gd', ':-tabnew %<cr>:Gdiffsplit! <cr>')
end

configs['rnvimr'] = function()
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_enable_picker = 0
  vim.g.rnvimr_enable_bw = 1
  vim.g.rnvimr_draw_border = 0
  vim.g.rnvimr_layout = {
    relative = 'editor',
    width = math.floor(0.9 * vim.o.columns),
    height = math.floor(0.8 * vim.o.lines),
    col = math.floor(0.05 * vim.o.columns),
    row = math.floor(0.05 * vim.o.lines),
    style = 'minimal',
    border = 'rounded',
  }
end

setups['rnvimr'] = function()
  local noremap = require 'utils'.noremap
  noremap('n', '<leader>rr', ':RnvimrToggle<CR>')
end

configs['todo-comments.nvim'] = function()
  require("todo-comments").setup {}
end

setups['vim-maximizer'] = function()
  vim.g.maximizer_set_default_mapping = 0

  local noremap = require 'utils'.noremap
  noremap('n', '<C-W>m', ':MaximizerToggle!<CR>')
  noremap('n', '<C-W><CR>', ':MaximizerToggle!<CR>')
end

setups['vim-dispatch'] = function()
  vim.g.dispatch_no_maps = 1
  local noremap = require 'utils'.noremap
  noremap('n', '<leader>m', ':Make<cr>')
end

--------------------------------------------------------------------------------

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/voldikss/vim-floaterm',
    setup = setups['vim-floaterm'],
    cmd = { 'Floaterm*', },
  }

  use {
    p 'https://github.com/mhinz/vim-grepper',
    setup = setups['vim-grepper'],
    cmd = { 'Grepper*', },
    keys = '<Plug>(GrepperOperator)',
  }

  use {
    p 'https://github.com/kevinhwang91/nvim-bqf',
    event = 'FileType qf',
  }

  use {
    p 'https://github.com/kevinhwang91/rnvimr',
    setup = setups['rnvimr'],
    config = configs['rnvimr'],
    cmd = 'Rnvimr*',
  }

  use {
    p 'https://github.com/tpope/vim-fugitive',
    setup = setups['vim-fugitive'],
    cmd = { 'Git', 'Gclog', 'Gdiffsplit', 'GBrowse' },
    requires = { p 'https://github.com/tpope/vim-rhubarb', },
  }

  use {
    p 'https://github.com/folke/todo-comments.nvim',
    cmd = { 'TodoQuickFix', 'TodoLocList', },
    config = configs['todo-comments.nvim'],
    requires = 'nvim-lua/plenary.nvim',
  }

  use {
    p 'https://github.com/szw/vim-maximizer',
    setup = setups['vim-maximizer'],
    cmd = 'MaximizerToggle',
  }

  use {
    p 'https://github.com/tpope/vim-dispatch',
    setup = setups['vim-dispatch'],
    requires = {
      p 'https://github.com/radenling/vim-dispatch-neovim',
      after = 'vim-dispatch',
    },
  }
end
return M
