local configs = {}

local p = require'utils'.p

local M = function(use)
  use { p'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { p'https://github.com/tzachar/fuzzy.nvim' }
end
return M