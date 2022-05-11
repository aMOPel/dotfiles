local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'python',
})

add(g.lsp.servers, {
  'pylsp',
})

add(g.ts.ensure_installed, {
  'python',
})

add(g.ts.indent.disable, {
  'python',
})

return function(use) end
