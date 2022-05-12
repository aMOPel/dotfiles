local configs = {}

configs['vim-floaterm'] = function()
  vim.g.floaterm_shell = 'zsh'
  vim.g.floaterm_width = 0.7
  vim.g.floaterm_height = 0.7

  local noremap = require 'utils'.noremap
  noremap('n', '<leader>ff', ':FloatermToggle<CR>')
  noremap('t', '<C-W>', '<C-\\><C-n>:FloatermToggle<CR>')
  noremap('t', '<F11>', '<C-\\><C-n>')
  noremap('n', '<leader>fg', ':FloatermNew --autoclose=2 --disposable gitui<CR>')
  noremap('n', '<leader>ft', ':FloatermNew --autoclose=2 --disposable taskwarrior-tui<CR>')
  noremap('n', '<leader>fw', ':FloatermNew --autoclose=0 --disposable --width=0.9 timew week<CR>')
end

configs['vim-grepper'] = function()
vim.cmd([[
nnoremap <leader>gr :Grepper -tool rg<CR>
nnoremap <leader>*  :Grepper -tool rg -cword -noprompt<cr>

nmap gr <Plug>(GrepperOperator)
xmap gr <Plug>(GrepperOperator)

aug Grepper
    au!
    au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})
aug END

let g:grepper = {}
let g:grepper.open = 1
let g:grepper.switch = 1
let g:grepper.quickfix = 1
let g:grepper.searchreg = 1
let g:grepper.highlight = 1
let g:grepper.dir = 'cwd'
let g:grepper.tools = ['rg']

let g:grepper.operator = {}
let g:grepper.operator.open = 1
let g:grepper.operator.switch = 1
let g:grepper.operator.prompt = 0
let g:grepper.operator.quickfix = 1
let g:grepper.operator.searchreg = 1
let g:grepper.operator.highlight = 1
let g:grepper.operator.dir = 'cwd'
let g:grepper.operator.tools = ['rg']

" let g:grepper.rg.grepprg .= ' --smart-case'
]])
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/voldikss/vim-floaterm',
    config = configs['vim-floaterm'],
  }
  use {
    p 'https://github.com/kevinhwang91/nvim-bqf',
  }
  use {
    p 'https://github.com/mhinz/vim-grepper',
    config = configs['vim-grepper'],
  }
end
return M
-- # [[plugins]]
-- # repo = 'https://github.com/NTBBloodbath/rest.nvim'
-- # if = 'has("nvim")'
-- # depends = 'plenary'
-- # hook_add = '''
-- #   nmap <silent> <leader>cc <Plug>RestNvim
-- #   nmap <silent> <leader>cp <Plug>RestNvimPreview
-- #   nmap <silent> <leader>cr <Plug>RestNvimLast
-- # '''
-- # hook_post_source = '''
-- # lua <<EOF
-- # require("rest-nvim").setup({
-- #     -- Open request results in a horizontal split
-- #     result_split_horizontal = false,
-- #     -- Skip SSL verification, useful for unknown certificates
-- #     skip_ssl_verification = false,
-- #     -- Highlight request on run
-- #     highlight = {
-- #       enabled = true,
-- #       timeout = 150,
-- #     },
-- #     -- Jump to request line on run
-- #     jump_to_request = false,
-- #   })
-- # EOF
-- # '''
--
-- # [[plugins]]
-- # repo = 'https://github.com/nvim-neorg/neorg'
-- # depends = 'plenary'
-- # hook_post_source = '''
-- # lua << EOF
-- #   require('neorg').setup {
-- #       -- Tell Neorg what modules to load
-- #       load = {
-- #           ["core.defaults"] = {}, -- Load all the default modules
-- #           ["core.norg.concealer"] = {}, -- Allows for use of icons
-- #           ["core.norg.dirman"] = { -- Manage your directories with Neorg
-- #               config = {
-- #                   workspaces = {
-- #                       my_workspace = "~/neorg"
-- #                   }
-- #               }
-- #           },
-- #           ["core.keybinds"] = { -- Configure core.keybinds
-- #               config = {
-- #                   default_keybinds = true, -- Generate the default keybinds
-- #                   neorg_leader = "<Leader>o" -- This is the default if unspecified
-- #               }
-- #           },
-- #           ["core.norg.completion"] = {
-- #             config = {
-- #               engine = "nvim-cmp",
-- #             },
-- #           },
-- #       },
-- #   }
-- # EOF
-- # '''
--
--
-- # for harpoon
-- # [[plugins]]
-- # repo = 'nvim-lua/popup.nvim'
-- # if = 'has("nvim")'
-- # name = 'popup'
--
-- # [[plugins]]
-- # repo = 'ThePrimeagen/harpoon'
-- # if = 'has("nvim")'
-- # on_lua = 'harpoon'
-- # depends = ['popup', 'plenary']
-- # hook_add = '''
-- #   nnoremap <leader>hh :lua require("harpoon.ui").toggle_quick_menu()<cr>
-- #   nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
-- #   nnoremap <C-m> :lua require("harpoon.ui").nav_file(1)<CR>
-- #   nnoremap <C-n> :lua require("harpoon.ui").nav_file(2)<CR>
-- #   nnoremap <C-h> :lua require("harpoon.ui").nav_file(3)<CR>
-- #   nnoremap <C-y> :lua require("harpoon.ui").nav_file(4)<CR>
-- #   autocmd MyAutoCmd FileType harpoon nnoremap <buffer> <esc> :wq<cr>
-- # '''
-- # hook_post_source = '''
-- # lua <<EOF
-- # require("harpoon").setup({
-- #   global_settings = {
-- #       save_on_toggle = false,
-- #       save_on_change = true,
-- #   },
-- # })
-- # EOF
-- # '''
--
-- # -------------------------------------------------------------------
-- # test
--
-- [[plugins]]
-- repo = 'https://github.com/folke/which-key.nvim'
-- hook_post_source = '''
-- lua <<EOF
-- require("which-key").setup{
--   plugins = {
--     marks = false,
--     spelling = {
--       enabled = true,
--       suggestions = 20,
--     },
--   },
-- }
-- EOF
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/simrat39/symbols-outline.nvim'
-- hook_add = '''
-- lua <<EOF
-- vim.g.symbols_outline = {
--   highlight_hovered_item = true,
--   show_guides = true,
--   auto_preview = false,
--   position = 'right',
--   relative_width = true,
--   width = 50,
--   show_numbers = false,
--   show_relative_numbers = false,
--   show_symbol_details = true,
--   preview_bg_highlight = 'Pmenu',
--   keymaps = { -- These keymaps can be a string or a table for multiple keys
--       close = {"<Esc>", "q"},
--       goto_location = "<Cr>",
--       focus_location = "o",
--       hover_symbol = "<C-space>",
--       toggle_preview = "K",
--       rename_symbol = "r",
--       code_actions = "a",
--   },
--   lsp_blacklist = {},
--   symbol_blacklist = {},
--   symbols = {
--       File = {icon = "", hl = "TSURI"},
--       Module = {icon = "", hl = "TSNamespace"},
--       Namespace = {icon = "", hl = "TSNamespace"},
--       Package = {icon = "", hl = "TSNamespace"},
--       Class = {icon = "𝓒", hl = "TSType"},
--       Method = {icon = "ƒ", hl = "TSMethod"},
--       Property = {icon = "", hl = "TSMethod"},
--       Field = {icon = "", hl = "TSField"},
--       Constructor = {icon = "", hl = "TSConstructor"},
--       Enum = {icon = "ℰ", hl = "TSType"},
--       Interface = {icon = "ﰮ", hl = "TSType"},
--       Function = {icon = "", hl = "TSFunction"},
--       Variable = {icon = "", hl = "TSConstant"},
--       Constant = {icon = "", hl = "TSConstant"},
--       String = {icon = "𝓐", hl = "TSString"},
--       Number = {icon = "#", hl = "TSNumber"},
--       Boolean = {icon = "⊨", hl = "TSBoolean"},
--       Array = {icon = "", hl = "TSConstant"},
--       Object = {icon = "⦿", hl = "TSType"},
--       Key = {icon = "🔐", hl = "TSType"},
--       Null = {icon = "NULL", hl = "TSType"},
--       EnumMember = {icon = "", hl = "TSField"},
--       Struct = {icon = "𝓢", hl = "TSType"},
--       Event = {icon = "🗲", hl = "TSType"},
--       Operator = {icon = "+", hl = "TSOperator"},
--       TypeParameter = {icon = "𝙏", hl = "TSParameter"}
--   }
-- }
-- EOF
-- '''
-- # -------------------------------------------------------------------
-- # bigger frameworks or functions
--
-- [[plugins]]
-- repo = 'https://github.com/tpope/vim-speeddating'
-- on_cmd = 'SpeedDatingFormat'
-- on_map = { n = ['<c-a>', '<c-x>'] }
-- hook_post_source = '''
-- 1SpeedDatingFormat %-d-%-m-%y
-- '''
--
-- #for rest, harpoon and todo
-- [[plugins]]
-- repo = 'nvim-lua/plenary.nvim'
-- if = 'has("nvim")'
-- name = 'plenary'
--
-- [[plugins]]
-- repo = 'https://github.com/folke/todo-comments.nvim'
-- depends = 'plenary'
-- on_cmd = ['TodoQuickFix', 'TodoLocList']
-- hook_source = '''
-- lua <<EOF
--   require("todo-comments").setup{}
-- EOF
-- '''
--
-- [[plugins]]
-- repo = 'tpope/vim-fugitive'
-- on_cmd = ['Git', 'Gclog', 'Gdiffsplit', 'GBrowse']
-- depends = 'rhubarb'
-- hook_add = '''
--   nnoremap <leader>gg :-tabnew<cr>:Git ++curwin<CR>
--   nnoremap <leader>gl :-tabnew<cr>:Gclog <CR>
--   nnoremap <leader>gd :-tabnew %<cr>:Gdiffsplit! <cr>
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/tpope/vim-rhubarb'
-- name = 'rhubarb'
--
-- [[plugins]]
-- repo = 'https://github.com/MattesGroeger/vim-bookmarks'
-- on_map = '<Plug>Bookmark'
-- hook_add = '''
--   let g:bookmark_sign = '📘'
--   let g:bookmark_annotation_sign = '📗'
--   let g:bookmark_no_default_key_mappings = 1
--   let g:bookmark_auto_save_file = stdpath('data') . '/bookmarks'
--
--   nmap <Leader>bb <Plug>BookmarkToggle
--   nmap <Leader>bi <Plug>BookmarkAnnotate
--   nmap <Leader>ba <Plug>BookmarkShowAll
--   nmap <Leader>bn <Plug>BookmarkNext
--   nmap <Leader>bp <Plug>BookmarkPrev
--   nmap <Leader>bc <Plug>BookmarkClear
--   nmap <Leader>bx <Plug>BookmarkClearAll
--   nmap <Leader>bk <Plug>BookmarkMoveUp
--   nmap <Leader>bj <Plug>BookmarkMoveDown
--   nmap <Leader>bg <Plug>BookmarkMoveToLine
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/FooSoft/vim-argwrap'
-- on_map = { n = ['gJ'] }
-- hook_add = '''
--   nnoremap gJ :ArgWrap<CR>
--   let g:argwrap_tail_comma_braces = '[{'
-- '''
--
-- # [[plugins]]
-- # repo = 'https://github.com/AndrewRadev/splitjoin.vim'
-- # on_map = { n = [' J', ' j'] }
-- # hook_source = '''
-- #   let g:splitjoin_split_mapping = ''
-- #   let g:splitjoin_join_mapping = ''
-- #
-- #   nmap <Leader>J :SplitjoinJoin<cr>
-- #   nmap <Leader>j :SplitjoinSplit<cr>
-- # '''
-- # # only has clever definitions for these fts
-- # on_ft = [
-- #   'c',
-- #   'coffee',
-- #   'css',
-- #   'elixir',
-- #   'elm',
-- #   'eruby',
-- #   'go',
-- #   'haml',
-- #   'handlebars',
-- #   'html',
-- #   'java',
-- #   'javascript',
-- #   'json',
-- #   'jsx',
-- #   'tsx',
-- #   'lua',
-- #   'perl',
-- #   'php',
-- #   'python',
-- #   'r',
-- #   'ruby',
-- #   'rust',
-- #   'scss',
-- #   'less',
-- #   'shell',
-- #   'tex',
-- #   'vimscript',
-- #   'yaml',
-- # ]
--
-- [[plugins]]
-- repo = 'https://github.com/aMOPel/vim-log-print'
-- on_map = '<Plug>LogPrint'
-- hook_add = '''
-- 	let g:log_print#default_mappings = 0
--
-- 	nmap <silent> gl <Plug>LogPrintToggle
-- 	nmap <silent> [g <Plug>LogPrintAbove
-- 	nmap <silent> ]g <Plug>LogPrintBelow
--
-- 	let g:log_print#languages = #{
-- 		\ gdscript: #{pre:"print(", post:")"},
-- 		\ typescript: #{pre:"console.log(", post:")"},
-- 		\ sh: #{pre:"echo "},
-- 		\ nim: #{pre:"echo "},
-- 		\ }
-- '''
--
-- # [[plugins]]
-- # repo = 'tversteeg/registers.nvim'
-- # if = 'has("nvim")'
-- # on_cmd = 'Registers'
-- # on_map = {
-- #   i = '<c-r>',
-- #   n = '"',
-- #   v = '"',
-- # }
--
-- [[plugins]]
-- repo = 'szw/vim-maximizer'
-- on_cmd = 'Maximizer'
-- hook_add = '''
--   let g:maximizer_set_default_mapping = 0
--   nnoremap <c-w>m :MaximizerToggle!<CR>
--   nnoremap <c-w><c-m> :MaximizerToggle!<CR>
-- '''
--
-- # [[plugins]]
-- # repo = 'kana/vim-altr'
-- # on_map = '<Plug>'
-- # hook_add = '''
-- #   nmap <leader>a <Plug>(altr-back)
-- #   nmap <leader>A <Plug>(altr-forward)
-- # '''
-- # hook_source = '''
-- #   " call altr#remove_all()
-- #   call altr#define('%/src/%.cpp', '%/src/%.h*', '%/include/%.h*')
-- #   call altr#define('%.gd', 'test/unit/test_%.gd')
-- #   call altr#define('addons/*/%.gd', 'test/unit/test_%.gd')
-- # '''
--
