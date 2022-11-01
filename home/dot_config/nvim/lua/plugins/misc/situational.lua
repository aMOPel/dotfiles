local plugins = require 'globals'.plugins

table.insert(plugins, {
  name = 'vim-floaterm',
  setup = function()
    vim.g.floaterm_shell = 'zsh'
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_opener = 'tabe'

    local noremap = require 'utils'.noremap
    noremap('n', '<leader>ff', ':FloatermToggle<CR>')
    noremap('t', '<C-W>', '<C-\\><C-n>:FloatermToggle<CR>')
    noremap('n', '<leader>fm', ':exec "FloatermNew --autoclose=0 --disposable " . &makeprg<CR>')
    noremap('n', '<leader>fg', ':FloatermNew --autoclose=1 --width=1.0 --height=1.0 lazygit<CR>')
    noremap('n', '<leader>ft', ':FloatermNew --autoclose=2 --disposable taskwarrior-tui<CR>')
    noremap('n', '<leader>fw', ':FloatermNew --autoclose=0 --disposable --width=0.9 timew week<CR>')
  end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'vim-grepper',
  setup = function()
    local noremap = require 'utils'.noremap
    local map = require 'utils'.map
    noremap('n', '<c-f>', ':Grepper -tool rg<CR>')
    -- noremap('n', '<leader>*', ':Grepper -tool rg -cword -noprompt<cr>')

    map('n', 'gs', '<Plug>(GrepperOperator)')
    map('x', 'gs', '<Plug>(GrepperOperator)')

    vim.cmd([[
aug Grepper
  au!
  au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})
aug END
]]   )

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
      rg = {
        grepprg = 'rg -H --no-heading --vimgrep --smart-case --'
      },
      operator = {
        open = 1,
        switch = 1,
        prompt = 0,
        quickfix = 1,
        searchreg = 1,
        highlight = 1,
        dir = 'cwd',
        tools = { 'rg' },
        rg = {
          grepprg = 'rg -H --no-heading --vimgrep --smart-case --'
        },
      },
    }
  end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'vim-fugitive',
  setup = function()
    local noremap = require 'utils'.noremap
    noremap('n', '<leader>gg', ':-tabnew<cr>:Git ++curwin<CR>')
    noremap('n', '<leader>gl', ':-tabnew<cr>:Gclog <CR>')
    noremap('n', '<leader>gd', ':-tabnew %<cr>:Gdiffsplit! <cr>')
    vim.cmd [[au MyPlugins Filetype gitcommit nnoremap <buffer> <c-s> :wq<cr>]]
  end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'rnvimr',
  setup = function()
    local noremap = require 'utils'.noremap
    noremap('n', '-', ':RnvimrToggle<CR>')
  end,
  config = function()
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
  end,
})


table.insert(plugins, {
  name = 'todo-comments.nvim',
  setup = function()
  end,
  config = function()
    require('todo-comments').setup {
      keywords = {
        DONE = { icon = ' ', color = 'done', },
        TODO = { icon = ' ', color = 'info', },
      },
      colors = {
        done = { '#84da94', },
      },
    }
  end,
})

table.insert(plugins, {
  name = 'vim-maximizer',
  setup = function()
    vim.g.maximizer_set_default_mapping = 0

    local noremap = require 'utils'.noremap
    noremap('n', '<C-W>m', ':MaximizerToggle!<CR>')
    noremap('n', '<C-W><C-M>', ':MaximizerToggle!<CR>')
  end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'vim-dispatch',
  setup = function()
    vim.g.dispatch_no_maps = 1
    local noremap = require 'utils'.noremap
    noremap('n', '<leader>m', ':Make<cr>')
  end,
  config = function()
  end,
})

table.insert(plugins, {
  setup = function()
  end,
  config = function()
        },
      },

  end,
})

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/voldikss/vim-floaterm', }
  use { p 'https://github.com/mhinz/vim-grepper', }
  use { p 'https://github.com/kevinhwang91/nvim-bqf', }
  use { p 'https://github.com/kevinhwang91/rnvimr', }
  use { p 'https://github.com/szw/vim-maximizer', }
  use {
    p 'https://github.com/tpope/vim-fugitive',
    requires = { p 'https://github.com/tpope/vim-rhubarb', after = 'vim-fugitive' },
  }
  use {
    p 'https://github.com/folke/todo-comments.nvim',
    requires = { p 'https://github.com/nvim-lua/plenary.nvim', },
  }
  use {
    p 'https://github.com/tpope/vim-dispatch',
    requires = { p 'https://github.com/radenling/vim-dispatch-neovim', after = 'vim-dispatch', },
  }
  use {
    p 'https://github.com/simnalamburt/vim-mundo',
    commit = '595ee332719f397c2441d85f79608113957cc78f',
  }
end
return M
