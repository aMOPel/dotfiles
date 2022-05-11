local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'sh',
})

add(g.lsp.servers, {
  'bashls',
})

add(g.ts.ensure_installed, {
  'bash',
})

return function(use) end
