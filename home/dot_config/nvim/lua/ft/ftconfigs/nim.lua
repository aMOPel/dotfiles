local g = require("globals")
local add = require("utils").addTable

local ft = "nim"

add(g.lsp.fts, {
	ft,
	-- 'nims',
})

-- add(g.lsp.servers.lsp_installer, {
-- 	nimls = "default",
-- })

add(g.lsp.servers.other, {
	nim_langserver = "default",
})

-- add(g.treesitter.ensure_installed, {
-- })

add(g.formatter.filetype, {
	[ft] = function()
		return {
			exe = "nimpretty",
			args = {
				vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
			},
			stdin = false,
		}
	end,
})

-- add(g.formatter.on_save, {
-- 	"*." .. ft,
-- })

g.recipes[ft] = {
  nimble_build_main = {
    cmd = "nimble --silent builds --verbosity:0 --listfullpaths",
    kind = "build",
    restart = true,
  },
  nimble_run_main = {
    cmd = "nimble --silent runs",
    kind = "term",
    depends_on = {"nimble_build_main"},
  },
  nimble_build = {
    cmd = "nimble --silent builds --verbosity:0 --listfullpaths %",
    kind = "build",
    restart = true,
  },
  nimble_run = {
    cmd = "nimble --silent runs %",
    kind = "term",
    depends_on = {"nimble_build"},
  },
  nimble_build_test = {
    cmd = "nimble --silent build_tests --verbosity:0 --listfullpaths %",
    kind = "build",
    restart = true,
  },
  nimble_run_test = {
    cmd = "nimble --silent run_tests --verbosity:0 --listfullpaths %",
    kind = "term",
    depends_on = {"nimble_build_test"},
  },
  nimble_build_testsuite = {
    cmd = "nimble --silent build_tests --verbosity:0 --listfullpaths",
    kind = "build",
    restart = true,
  },
  nimble_run_testsuite = {
    cmd = "nimble --silent run_tests --verbosity:0 --listfullpaths",
    kind = "term",
    depends_on = {"nimble_build_testsuite"},
  },
  build = {
    cmd = "nim c --outDir:bin --verbosity:0 --listfullpaths %:p",
    kind = "build",
    restart = true,
  },
  run = {
    cmd = "./bin/%:t:r",
    kind = "term",
    depends_on = {"build"},
  },
}

local configs = {}

local function queryNimbleTasks()
  local tasks = vim.fn.systemlist("nimble --silent tasks")
  for _, task in ipairs(tasks) do
    if string.match(task, "^(%w+)%s") == "runs" then
      return true
    end
  end
  return false
end

local function getDefaultCrRhs()
  local rhs = ":Bake run<cr>"
  if queryNimbleTasks() then
    rhs = ":Bake nimble_run<cr>"
  end
  return rhs
end

configs[ft] = function()
	local noremap = require("utils").noremap_buffer
	noremap('n', '<cr>', getDefaultCrRhs())
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
	group = "MyFt",
	pattern = { ft },
	callback = configs[ft],
})
