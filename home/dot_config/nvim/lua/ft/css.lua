local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'css',
})

add(g.lsp.servers, {
  'tailwindcss',
})

add(g.ts.ensure_installed, {
  'css',
})

return function(use) end
