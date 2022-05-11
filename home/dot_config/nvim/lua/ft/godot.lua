local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'gdscript',
})

add(g.lsp.servers, {
  'gdscript',
})

add(g.ts.ensure_installed, {
  'gdscript',
  'godot_resource',
})

add(g.ts.indent.disable, {
  'gdscript',
})

return function(use) end
