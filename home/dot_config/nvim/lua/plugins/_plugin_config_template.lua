local configs = {}

configs[''] = function()
end

local p = require 'utils'.p

local M = function(use)
  use {
    p '',
    config = configs['']
  }
end
return M
