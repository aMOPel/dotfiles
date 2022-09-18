local g = require("globals")
local add = require("utils").addTable

local ft = "lua"

add(g.lsp.fts, {
	ft,
})

add(g.lsp.servers.lsp_installer, {
	sumneko_lua = function(on_attach, capabilities)
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")

		return {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Setup your lua path
						path = runtime_path,
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end,
})

add(g.treesitter.ensure_installed, {
	ft,
})

add(g.formatter.ensure_installed, {
	"stylua",
})

add(g.formatter.filetype, {
	[ft] = function()
		return {
			exe = "stylua",
			args = {
				"--search-parent-directories",
				"--column-width",
				"80",
				"--stdin-filepath",
				vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
				"--",
				"-",
			},
			stdin = true,
		}
	end,
})

-- add(g.formatter.on_save, {
-- 	"*." .. ft,
-- })

local configs = {}

configs[ft] = function()
	local optl = vim.opt_local
	local noremap = require("utils").noremap_buffer
	noremap(
		"n",
		"<leader>n",
		':exec "FloatermNew --autoclose=0 --disposable luajit " . resolve(expand("%:p")) <CR>'
	)
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
	group = "MyFt",
	pattern = { ft },
	callback = configs[ft],
})
