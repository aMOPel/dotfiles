local g = require("globals")
local add = require("utils").addTable

local ft = "markdown"

add(g.lsp.fts, {
	ft,
})

add(g.lsp.servers.lsp_installer, {
	prosemd_lsp = "default",
})

add(g.formatter.filetype, {
	[ft] = { require("formatter.filetypes")[ft].prettierd },
})

add(g.formatter.on_save, {
	"*." .. ft,
})

-- add(g.treesitter.ensure_installed, {
--   ft,
-- })

local configs = {}

configs[ft] = function()
	local optl = vim.opt_local
	-- " setl spelllang=en,de
	-- " setl spell
	-- " setl textwidth=80
	--
	-- " setl linebreak
	-- " setl showbreak="> "
	-- " setl breakindent
	-- " setl formatoptions+=wa

	optl.foldenable = false
	optl.foldcolumn = "0"

	vim.g.GripRunning = 0
	function start_grip()
		if vim.g.GripRunning == 0 then
			local id = vim.fn.jobstart({ "grip", vim.fn.expand("%") }, {
				on_exit = function(job_id, data, name)
					print("grip exited")
				end,
				-- on_stderr = function(job_id, data, name) print('grip error: ') vim.pretty_print(data) end,
			})
			vim.g.GripRunning = 1
			vim.g.GripProcId = id
		else
			print("grip is already running")
		end
	end

	-- in case you want to stop it manually
	function stop_grip()
		if vim.g.GripRunning == 1 then
			vim.fn.jobstop(vim.g.GripProcId)
			vim.g.GripRunning = 0
		else
			print("grip is not running")
		end
	end

	local noremap = require("utils").noremap_buffer
	noremap(
		"n",
		"<leader>n",
		':exec "lua start_grip()" | call system(["brave-browser", "--new-window", "--", "http://localhost:6419/"])<cr>'
	)
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
	group = "MyFt",
	pattern = { ft },
	callback = configs[ft],
})
