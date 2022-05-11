
local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'c',
  'cpp',
  'objc',
  'objcpp',
})

add(g.lsp.servers, {
  'clangd',
})

add(g.ts.ensure_installed, {
  'c',
  'cpp',
})

return function(use) end
