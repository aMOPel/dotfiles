local g = require("globals")
local add = require("utils").addTable

local ft = "gitcommit"

-- add(g.lsp.fts, {
-- 	ft,
-- })

-- add(g.lsp.servers.lsp_installer, {
-- 	-- server_name = function(on_attach, capabilities) end,
-- 	server_name = "default",
-- })

add(g.treesitter.ensure_installed, {
	"gitignore",
	"gitattributes",
	"gitcommit",
	"git_config",
	"git_rebase",
	"diff",
})

-- add(g.treesitter.indent.disable, {
-- 	ft,
-- })

-- add(g.formatter.ensure_installed, {
-- 	"prettierd",
-- })

-- add(g.formatter.filetype, {
-- 	[ft] = { require("formatter.filetypes")[ft].prettierd },
-- })

-- add(g.formatter.on_save, {
-- 	"*." .. ft,
-- })

add(g.linter.ensure_installed, {
	"gitlint",
})

add(g.linter.filetype, {
	[ft] = {
		"gitlint",
	},
})

add(g.linter.custom_linter, {
	"",
})

-- add(g.dap.ensure_installed, {
-- 	"",
-- })

-- add(g.dap.filetype, {
-- 	"",
-- })

-- local configs = {}
-- configs[ft] = function()
-- 	local optl = vim.opt_local
-- 	local noremap = require("utils").noremap_buffer
-- end

-- vim.api.nvim_create_autocmd({ "Filetype" }, {
-- 	group = "MyFt",
-- 	pattern = { ft },
-- 	callback = configs[ft],
-- })
