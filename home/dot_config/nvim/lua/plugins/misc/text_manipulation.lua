local plugins = require'globals'.plugins

table.insert(plugins, {
  name = 'vim-sandwich',
  setup = function()
  vim.cmd [[runtime vimscript/vim-sandwich/surround.vim]]

  local map = require 'utils'.map
  map('x', 'is', '<Plug>(textobj-sandwich-query-i)')
  map('x', 'as', '<Plug>(textobj-sandwich-query-a)')
  map('o', 'is', '<Plug>(textobj-sandwich-query-i)')
  map('o', 'as', '<Plug>(textobj-sandwich-query-a)')
  map('x', 'iss', '<Plug>(textobj-sandwich-auto-i)')
  map('x', 'ass', '<Plug>(textobj-sandwich-auto-a)')
  map('o', 'iss', '<Plug>(textobj-sandwich-auto-i)')
  map('o', 'ass', '<Plug>(textobj-sandwich-auto-a)')
  --   " example: dim( in 'outer(in|ner())' would delete 'inner', not 'inner()'
  -- 	" xmap im <Plug>(textobj-sandwich-literal-query-i)
  -- 	" xmap am <Plug>(textobj-sandwich-literal-query-a)
  -- 	" omap im <Plug>(textobj-sandwich-literal-query-i)
  -- 	" omap am <Plug>(textobj-sandwich-literal-query-a)
  end,
  config = function()
end,
})

table.insert(plugins, {
  name = 'Comment.nvim',
  setup = function()
  end,
  config = function()
  require('Comment').setup {
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
    toggler = {
      line = 'gcc',
      -- block = '',
    },
    opleader = {
      line = 'gc',
      -- block = '',
    },
    pre_hook = function(ctx)
      local u = require('Comment.utils')
      if ctx.ctype == u.ctype.line or ctx.cmotion == u.cmotion.line then
        return require('ts_context_commentstring.internal').calculate_commentstring()
      end
    end,
  }
end,
})

table.insert(plugins, {
  name = 'vim-surround-funk',
  setup = function()
  end,
  config = function()
  vim.g.surround_funk_create_mappings = 0

  local map = require 'utils'.map
  map('n', 'dsf', '<Plug>(DeleteSurroundingFunction)')
  map('n', 'dsF', '<Plug>(DeleteSurroundingFUNCTION)')
  map('n', 'csf', '<Plug>(ChangeSurroundingFunction)')
  map('n', 'csF', '<Plug>(ChangeSurroundingFUNCTION)')
  map('n', 'ysf', '<Plug>(YankSurroundingFunction)')
  map('n', 'ysF', '<Plug>(YankSurroundingFUNCTION)')
  map('x', 'af', '<Plug>(SelectWholeFunction)')
  map('o', 'af', '<Plug>(SelectWholeFunction)')
  map('x', 'aF', '<Plug>(SelectWholeFUNCTION)')
  map('o', 'aF', '<Plug>(SelectWholeFUNCTION)')
  map('x', 'if', '<Plug>(SelectWholeFunction)')
  map('o', 'if', '<Plug>(SelectWholeFunction)')
  map('x', 'iF', '<Plug>(SelectWholeFUNCTION)')
  map('o', 'iF', '<Plug>(SelectWholeFUNCTION)')
  map('x', 'an', '<Plug>(SelectFunctionName)')
  map('o', 'an', '<Plug>(SelectFunctionName)')
  map('x', 'aN', '<Plug>(SelectFunctionNAME)')
  map('o', 'aN', '<Plug>(SelectFunctionNAME)')
  map('x', 'in', '<Plug>(SelectFunctionName)')
  map('o', 'in', '<Plug>(SelectFunctionName)')
  map('x', 'iN', '<Plug>(SelectFunctionNAME)')
  map('o', 'iN', '<Plug>(SelectFunctionNAME)')
  -- map('n', 'gpf', '<Plug>(GripSurroundObject)')
  -- map('v', 'gpf', '<Plug>(GripSurroundObject)')
  -- nmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
  -- vmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
end,
})

table.insert(plugins, {
  name = 'CamelCaseMotion',
  setup = function()
  end,
  config = function()
  -- vim.g.camelcasemotion_key = ','
  local map = require 'utils'.map
  map('', ',w', '<Plug>CamelCaseMotion_w')
  map('', ',b', '<Plug>CamelCaseMotion_b')
  map('', ',e', '<Plug>CamelCaseMotion_e')
  map('', ',ge', '<Plug>CamelCaseMotion_ge')
end,
})

table.insert(plugins, {
  name = 'switch.vim',
  setup = function()
  end,
  config = function()
  vim.g.switch_mapping = "gs"
end,
})

table.insert(plugins, {
  name = 'vim-log-print',
  setup = function()
  vim.g['log_print#default_mappings'] = 0

  vim.g['log_print#languages'] = {
    gdscript = { pre = "print(", post = ")" },
    typescript = { pre = "console.log(", post = ")" },
    sh = { pre = "echo " },
    nim = { pre = "echo " },
  }

  local map = require 'utils'.map
  map('n', 'gl', '<Plug>LogPrintToggle')
  map('n', '[g', '<Plug>LogPrintAbove')
  map('n', ']g', '<Plug>LogPrintBelow')
end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'vim-argwrap',
  setup = function()
  local noremap = require 'utils'.noremap
  noremap('n', 'gJ', ':ArgWrap<CR>')
  vim.g.argwrap_tail_comma_braces = '[{'
end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'textobj-word-column.vim',
  setup = function()
  end,
  config = function()
  vim.g.textobj_wordcolumn_no_default_key_mappings = 1

  vim.fn['textobj#user#map']('wordcolumn', {
    word = {
      ['select-i'] = 'ic',
      ['select-a'] = 'ac',
    },
    WORD = {
      ['select-i'] = 'iC',
      ['select-a'] = 'aC',
    },
  })
end,
})

table.insert(plugins, {
  name = 'textobj-pastedtext.vim',
  setup = function()
  vim.g.pastedtext_select_key = 'gp'
end,
  config = function()
  end,
})

table.insert(plugins, {
  name = 'targets.vim',
  setup = function()
  end,
  config = function()
  vim.g.targets_aiAI = { 'a', 'i', ' ', ' ' }
  vim.g.targets_nl = { ' ', ' ' }
  vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'
  vim.cmd [[
autocmd MyPlugins User targets#mappings#user call targets#mappings#extend({
    \ 'a': {'argument': [{'o': '[([{]', 'c': '[}])]', 's': ','}]},
    \ })
]]

  -- vim.api.nvim_create_autocmd(
  --   { 'User' },
  --   {
  --   pattern = 'targets#mappings#user',
  --   group = 'MyAutoCmd',
  --   callback = function()
  --     vim.fn['targets#mappings#extend']({
  --       a = {},
  --     })
  --   end,
  --   once = true,
  -- })
end,
})

table.insert(plugins, {
  name = 'regreplop.vim',
  setup = function()
  end,
  config = function()
  local map = require 'utils'.map
  map('n', '<c-p>', '<Plug>ReplaceMotion')
  map('n', '<c-p><c-p>', '<Plug>ReplaceLine')
  map('v', '<c-p>', '<Plug>ReplaceVisual')
end,
})

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/machakann/vim-sandwich', }
  use { p 'https://github.com/tommcdo/vim-exchange', }
  use { p 'https://github.com/numToStr/Comment.nvim', }
  use { p 'https://github.com/Matt-A-Bennett/vim-surround-funk', }
  use { p 'https://github.com/bkad/CamelCaseMotion', }
  use { p 'https://github.com/AndrewRadev/switch.vim', }
  -- use { p 'https://github.com/AndrewRadev/deleft.vim', }
  use { p 'https://github.com/FooSoft/vim-argwrap', }
  use { p 'https://github.com/wellle/targets.vim', }
  use { p 'https://github.com/vim-scripts/regreplop.vim', }
  use {
    p 'https://github.com/aMOPel/vim-log-print',
    requires = { 'https://github.com/Shougo/context_filetype.vim', },
  }
  use {
    p 'https://github.com/kana/vim-textobj-user',
    requires = {
      { p 'https://github.com/kana/vim-textobj-indent', after = 'vim-textobj-user', },
      { p 'https://github.com/kana/vim-textobj-entire', after = 'vim-textobj-user', },
      -- { p 'https://github.com/Chun-Yang/vim-textobj-chunk', after = 'vim-textobj-user', },
      { p 'https://github.com/saaguero/vim-textobj-pastedtext', after = 'vim-textobj-user', },
      { p 'https://github.com/idbrii/textobj-word-column.vim', after = 'vim-textobj-user', },
    },
  }
end
return M
