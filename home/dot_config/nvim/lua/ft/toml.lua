local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'toml',
})

add(g.lsp.servers, {
  'taplo',
})

add(g.ts.ensure_installed, {
  'toml',
})

return function(use) end
