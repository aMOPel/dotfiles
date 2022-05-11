local configs = {}

configs['vim-sandwich'] = function()
  vim.cmd [[runtime viml/vim-sandwich/surround.vim]]

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
    opleader = {
      line = 'gc',
      block = 'gb',
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
  map('n', 'gpf', '<Plug>(GripSurroundObject)')
  map('v', 'gpf', '<Plug>(GripSurroundObject)')
  -- nmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
  -- vmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
end

configs['CamelCaseMotion'] = function()
  vim.g.camelcasemotion_key = ','
end

configs['switch.vim'] = function()
  vim.g.switch_mapping = "gs"
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/machakann/vim-sandwich',
    config = configs['vim-sandwich'],
  }
  use {
    p 'https://github.com/deris/vim-shot-f',
  }
  use {
    p 'https://github.com/tommcdo/vim-exchange',
  }
  use {
    p 'https://github.com/numToStr/Comment.nvim',
    config = configs['Comment.nvim'],
  }
  -- use {
  --   p 'https://github.com/michaeljsmith/vim-indent-object',
  -- }
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
  use {
    p 'https://github.com/AndrewRadev/deleft.vim',
  }
end
return M

-- # [[plugins]]
-- # repo = 'wellle/targets.vim'
-- # hook_add = '''
-- #   let g:targets_aiAI = 'ai  '
-- #   let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'
-- #   let g:targets_nl = '  '
-- # '''
