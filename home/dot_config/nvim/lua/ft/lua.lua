local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'lua',
})

add(g.lsp.servers, {
  'sumneko_lua',
})

add(g.ts.ensure_installed, {
  'lua',
})

return function(use) end
