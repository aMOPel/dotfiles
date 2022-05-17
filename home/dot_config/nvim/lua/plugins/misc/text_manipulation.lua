local configs = {}
local setups = {}

configs['vim-sandwich'] = function()
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
end

configs['Comment.nvim'] = function()
  require('Comment').setup {
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
    toggler = {
      line = 'gcc',
      block = '<nop>',
    },
    opleader = {
      line = 'gc',
      block = '<nop>',
    },
    pre_hook = function(ctx)
      local u = require('Comment.utils')
      if ctx.ctype == u.ctype.line or ctx.cmotion == u.cmotion.line then
        return require('ts_context_commentstring.internal').calculate_commentstring()
      end
    end,
  }
end

configs['vim-surround-funk'] = function()
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
end

configs['CamelCaseMotion'] = function()
  -- vim.g.camelcasemotion_key = ','
  local map = require 'utils'.map
  map('', ',w', '<Plug>CamelCaseMotion_w')
  map('', ',b', '<Plug>CamelCaseMotion_b')
  map('', ',e', '<Plug>CamelCaseMotion_e')
  map('', ',ge', '<Plug>CamelCaseMotion_ge')
end

configs['switch.vim'] = function()
  vim.g.switch_mapping = "gs"
end

setups['vim-log-print'] = function()
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
end

setups['vim-argwrap'] = function()
  local noremap = require 'utils'.noremap
  noremap('n', 'gJ', ':ArgWrap<CR>')
  vim.g.argwrap_tail_comma_braces = '[{'
end

configs['textobj-word-column.vim'] = function()
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
end

setups['textobj-pastedtext.vim'] = function()
  vim.g.pastedtext_select_key = 'gp'
end

configs['targets.vim'] = function()
  vim.g.targets_aiAI = 'ai  '
  vim.g.targets_nl = '  '
  vim.g.targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'
  vim.api.nvim_create_autocmd(
    {'User'},
    {
      pattern = 'targets#mappings#user',
      group = 'MyAutoCmd',
      callback = function()
        vim.fn['targets#mappings#extend']({
          a = {argument = {{o = '[{([]', c = '[])}]', s = ','}}},
        })
      end,
  })
end

configs['regreplop.vim'] = function()
  local map = require 'utils'.map
  map('n', '<c-p>', '<Plug>ReplaceMotion')
  map('n', '<c-p><c-p>', '<Plug>ReplaceLine')
  map('v', '<c-p>', '<Plug>ReplaceVisual')
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/machakann/vim-sandwich',
    config = configs['vim-sandwich'],
  }
  use { p 'https://github.com/tommcdo/vim-exchange', }
  use {
    p 'https://github.com/numToStr/Comment.nvim',
    config = configs['Comment.nvim'],
  }
  use {
    p 'https://github.com/Matt-A-Bennett/vim-surround-funk',
    config = configs['vim-surround-funk'],
  }
  use {
    p 'https://github.com/bkad/CamelCaseMotion',
    config = configs['CamelCaseMotion'],
  }
  use {
    p 'https://github.com/AndrewRadev/switch.vim',
    config = configs['switch.vim'],
  }
  -- use { p 'https://github.com/AndrewRadev/deleft.vim', }
  use {
    p 'https://github.com/aMOPel/vim-log-print',
    setup = setups['vim-log-print'],
    keys = '<Plug>LogPrint',
    requires = 'Shougo/context_filetype.vim',
  }
  use {
    p 'https://github.com/FooSoft/vim-argwrap',
    setup = setups['vim-argwrap'],
    cmd = 'ArgWrap',
  }
  use {
    p 'https://github.com/kana/vim-textobj-user',
    requires = {
      { p 'https://github.com/kana/vim-textobj-indent', after = 'vim-textobj-user', },
      { p 'https://github.com/kana/vim-textobj-entire', after = 'vim-textobj-user', },
      -- { p 'https://github.com/Chun-Yang/vim-textobj-chunk', after = 'vim-textobj-user', },
      {
        p 'https://github.com/saaguero/vim-textobj-pastedtext',
        setup = setups['textobj-pastedtext.vim'],
        after = 'vim-textobj-user',
      },
      {
        p 'https://github.com/idbrii/textobj-word-column.vim',
        config = configs['textobj-word-column.vim'],
        after = 'vim-textobj-user',
      },
    },
  }
  use {
    p 'https://github.com/wellle/targets.vim',
    config = configs['targets.vim'],
  }
  use {
    p 'https://github.com/vim-scripts/regreplop.vim',
    config = configs['regreplop.vim'],
  }

end
return M
