local g = require("globals")
local add = require("utils").addTable

local ft = "json"

add(g.lsp.fts, {
	ft,
})

add(g.lsp.servers.lsp_installer, {
	jsonls = function(on_attach, capabilities)
		return {
			filetypes = { "json" },
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			},
		}
	end,
})

add(g.treesitter.ensure_installed, {
	ft,
})

add(g.formatter.filetype, {
	[ft] = { require("formatter.filetypes")[ft].jq },
})

add(g.formatter.on_save, {
	"*." .. ft,
})
