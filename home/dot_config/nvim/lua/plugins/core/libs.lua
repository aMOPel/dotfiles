local configs = {}

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use { p 'https://github.com/tzachar/fuzzy.nvim', }
  use { p 'https://github.com/Shougo/context_filetype.vim', }
  use { p 'https://github.com/tpope/vim-repeat', }
  use { p 'https://github.com/nvim-lua/plenary.nvim', }
end
return M
