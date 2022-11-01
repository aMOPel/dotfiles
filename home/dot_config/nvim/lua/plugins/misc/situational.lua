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

-- table.insert(plugins, {
--   name = 'vim-dispatch',
--   setup = function()
--     vim.g.dispatch_no_maps = 1
--     local noremap = require 'utils'.noremap
--     noremap('n', '<cr>', ':Make<cr>')
--   end,
--   config = function()
--   end,
-- })

table.insert(plugins, {
  name = 'qf.nvim',
  setup = function()
    local noremap = require 'utils'.noremap
    noremap('n', 'Q', function () require'qf'.toggle('c', false) end)
  end,
  config = function()
    require'qf'.setup{
      l = {
        auto_close = true, -- Automatically close location/quickfix list if empty
        auto_follow = false, -- Follow current entry, possible values: prev,next,nearest, or false to disable
        auto_follow_limit = 8, -- Do not follow if entry is further away than x lines
        follow_slow = true, -- Only follow on CursorHold
        auto_open = true, -- Automatically open list on QuickFixCmdPost
        auto_resize = true, -- Auto resize and shrink location list if less than `max_height`
        max_height = 8, -- Maximum height of location/quickfix list
        min_height = 5, -- Minimum height of location/quickfix list
        wide = true, -- Open list at the very bottom of the screen, stretching the whole width.
        number = false, -- Show line numbers in list
        relativenumber = true, -- Show relative line numbers in list
        unfocus_close = false, -- Close list when window loses focus
        focus_open = false, -- Auto open list on window focus if it contains items
      },
      -- Quickfix list configuration
      c = {
        auto_close = true, -- Automatically close location/quickfix list if empty
        auto_follow = false, -- Follow current entry, possible values: prev,next,nearest, or false to disable
        auto_follow_limit = 8, -- Do not follow if entry is further away than x lines
        follow_slow = true, -- Only follow on CursorHold
        auto_open = true, -- Automatically open list on QuickFixCmdPost
        auto_resize = true, -- Auto resize and shrink location list if less than `max_height`
        max_height = 8, -- Maximum height of location/quickfix list
        min_height = 5, -- Minimum height of location/quickfix list
        wide = true, -- Open list at the very bottom of the screen, stretching the whole width.
        number = false, -- Show line numbers in list
        relativenumber = true, -- Show relative line numbers in list
        unfocus_close = false, -- Close list when window loses focus
        focus_open = false, -- Auto open list on window focus if it contains items
      },
      close_other = true, -- Close location list when quickfix list opens
      pretty = false, -- "Pretty print quickfix lists"
    }
  end,
})

table.insert(plugins, {
  name = 'recipe.nvim',
  setup = function()
    local noremap = require 'utils'.noremap
    noremap('n', '<leader>b', ':Bake')
    noremap('n', '<cr>', ':Bake run<cr>')
  end,
  config = function()
    local add = require("utils").addTable
    local recipes = require("globals").recipes
    add(recipes, require("recipe.ft"))

    require'recipe'.setup{
      term = {
        height = 0.8,
        width = 0.8,
        kind = "float",
        border = "single",
        jump_to_end = true,
        auto_close = false,
      },
      recipes_file = "recipes.json",
      --- Define custom global recipes, either globally or by filetype as key
      custom_recipes = recipes,
      hooks = {
        pre = {
          function(_)
            vim.cmd(":wa")
          end,
        },
      },

      ---@class Recipe
      ---@field cmd string
      ---@field cwd string
      ---@field kind string one of build,term,dap or a custom adapter
      ---@field plain boolean
      ---@field env table|nil
      ---@field opts table Extra options for the current backend
      ---@field depends_on (string|Recipe)[]
      default_recipe = {
        cmd = "",
        kind = "build",
        opts = {},
        restart = false,
        plain = false,
        depends_on = {},
        env = { __type = "table" },
      },

      adapters = {
        term = require("recipe.adapters.term"),
        build = require("recipe.adapters.build"),
        dap = require("recipe.adapters.dap"),
      },

      debug_adapters = {
        rust = require("recipe.debug_adapters").codelldb,
        c = require("recipe.debug_adapters").codelldb,
        cpp = require("recipe.debug_adapters").codelldb,
      },
      dotenv = ".env",
    }
  end,
})

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/voldikss/vim-floaterm', }
  use { p 'https://github.com/mhinz/vim-grepper', }
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
  -- use {
  --   p 'https://github.com/tpope/vim-dispatch',
  --   requires = { p 'https://github.com/radenling/vim-dispatch-neovim', after = 'vim-dispatch', },
  -- }
  use {
    p 'https://github.com/simnalamburt/vim-mundo',
    commit = '595ee332719f397c2441d85f79608113957cc78f',
  }

  use { p 'https://github.com/kevinhwang91/nvim-bqf', }
  use {
    p 'https://github.com/ten3roberts/recipe.nvim',
    requires = { p 'https://github.com/ten3roberts/qf.nvim', },
  }
end
return M
