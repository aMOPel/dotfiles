local plugins = require'globals'.plugins

table.insert(plugins, {
  name = 'dap',
  setup = function()
    local noremap = require("utils").noremap
    noremap("n", "<leader>db", ":DapToggleBreakpoint<cr>")
    noremap("n", "<leader>dd", ":DapContinue<cr>")
    noremap("n", "<leader>di", ":DapStepInto<cr>")
    noremap("n", "<leader>do", ":DapStepOut<cr>")
    noremap("n", "<leader>dt", ":DapTerminate<cr>")
  end,
  config = function()
		local g = require("globals")
		for filetype, callback in pairs(g.dap.filetype) do
      callback()
		end
  end,
})

table.insert(plugins, {
  name = 'dap-ui',
  setup = function()
  end,
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    local noremap = require("utils").noremap
    noremap("n", "<leader>du", [[:lua require("dapui").toggle()<cr>]])

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
})

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/mfussenegger/nvim-dap',
  }
  use {
    p 'https://github.com/rcarriga/nvim-dap-ui',
    require = {
      p 'https://github.com/mfussenegger/nvim-dap',
    },
  }
end
return M

-- [[plugins]]
-- repo = 'https://github.com/mfussenegger/nvim-dap'
-- if = 'has("nvim")'
-- name = 'dap'
-- on_lua = 'dap'
-- hook_source = '''
-- lua <<EOF
-- local dap = require("dap")
--
-- dap.adapters.chrome = {
--     type = "executable",
--     command = "node",
--     args = {os.getenv("HOME") .. "/.local/ghq/github.com/Microsoft/vscode-chrome-debug/out/src/chromeDebug.js"}
-- }
--
-- dap.configurations.javascript = {
--     {
--         type = "chrome",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}"
--     }
-- }
--
-- dap.configurations.typescript = {
--     {
--         type = "chrome",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}"
--     }
-- }
--
-- EOF
-- '''
-- hook_add = '''
-- 	" au MyAutoCmd FileType dap-repl lua require('dap.ext.autocompl').attach()
-- 	nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
-- 	nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
-- 	nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
-- 	nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
-- 	nnoremap <silent> <leader>dr :lua require'dap'.restart()<CR>
-- 	nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
-- 	nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- 	" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- 	" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
-- 	" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/rcarriga/nvim-dap-ui'
-- if = 'has("nvim")'
-- on_lua = 'dapui'
-- depends = 'dap'
-- hook_source = '''
-- lua <<EOF
-- require("dapui").setup({
--   -- icons = { expanded = "▾", collapsed = "▸" },
--   -- mappings = {
--   --   expand = { "<CR>", "<2-LeftMouse>" },
--   --   open = "o",
--   --   remove = "d",
--   --   edit = "e",
--   --   repl = "r",
--   -- },
--   sidebar = {
--     -- open_on_start = true,
--     size = 80,
--     position = "right",
--   },
--   tray = {
--     open_on_start = false,
--     -- elements = { "repl" },
--     -- height = 10,
--     -- position = "bottom",
--   },
--   -- floating = {
--   --   max_height = nil,
--   --   max_width = nil,
--   --   mappings = {
--   --     close = { "q", "<Esc>" },
--   --   },
--   -- },
--   windows = { indent = 1 },
-- })
-- EOF
-- '''
-- hook_add = '''
-- 	nnoremap <silent> <leader>du :lua require("dapui").toggle()<cr>
-- 	nnoremap <silent> <leader>de <Cmd>lua require("dapui").eval()<CR>
-- 	vnoremap <silent> <leader>de <Cmd>lua require("dapui").eval()<CR>
-- '''

-- https://github.com/sakhnik/nvim-gdb
