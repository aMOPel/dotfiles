local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'json',
})

add(g.lsp.servers, {
  'jsonls',
})

add(g.ts.ensure_installed, {
  'json',
})

return function(use) end
