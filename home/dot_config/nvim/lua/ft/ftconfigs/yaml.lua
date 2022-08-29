local g = require("globals")
local add = require("utils").addTable

local ft = "yaml"

add(g.lsp.fts, {
	ft,
})

add(g.lsp.servers.lsp_installer, {
	yamlls = "default",
})

add(g.treesitter.ensure_installed, {
	ft,
})

add(g.formatter.filetype, {
	[ft] = { require("formatter.filetypes")[ft].prettierd },
})

add(g.formatter.on_save, {
	"*." .. ft,
})
