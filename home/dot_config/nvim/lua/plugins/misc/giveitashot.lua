local plugins = require("globals").plugins

table.insert(plugins, {
	name = "delaytrain.nvim",
	setup = function()
	end,
	config = function()
    require('delaytrain').setup {
        delay_ms = 1000,  -- How long repeated usage of a key should be prevented
        grace_period = 2, -- How many repeated keypresses are allowed
        keys = {          -- Which keys (in which modes) should be delayed
            ['nv'] = {'w', 'W', 'b', 'B', 'e', 'E', 'h', 'j', 'k', 'l'},
            ['nvi'] = {'<Left>', '<Down>', '<Up>', '<Right>'},
            -- ['n'] = {'<c-d>', '<c-u>'},
        },
    }
  end,
})

local p = require("utils").p

local M = function(use)

  use { p "https://github.com/ja-ford/delaytrain.nvim" }

  -- use { p "https://github.com/tpope/vim-dadbod", }
  -- use { p "https://github.com/kristijanhusak/vim-dadbod-ui", }

  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
  -- TODO: look into gitsigns:
  -- https://github.com/lewis6991/gitsigns.nvim
  -- https://github.com/airblade/vim-gitgutter
  -- https://github.com/mhinz/vim-signify
  -- https://github.com/rhysd/git-messenger.vim
  -- https://github.com/f-person/git-blame.nvim
  -- https://github.com/APZelos/blamer.nvim
  -- https://github.com/tveskag/nvim-blame-line
  -- TODO: look into fugitive alternatives:
  -- https://github.com/jreybert/vimagit
  -- https://github.com/TimUntersberger/neogit
  -- https://github.com/tanvirtin/vgit.nvim
  -- https://github.com/akinsho/git-conflict.nvim
  -- https://github.com/sindrets/diffview.nvim
  -- TODO: look into gh plugins:
  -- https://github.com/tpope/vim-rhubarb
  -- https://github.com/pwntester/octo.nvim
  -- https://github.com/ldelossa/gh.nvim
  -- TODO: research: put dispatch results not always in qflist
  -- DONE: disable file preview in cmp-cmdline
  -- TODO: fix black git text
  -- TODO: incorporate PackerUpdate --preview
  -- DONE: fix error with rg, something sets cmdheight=1, but what?
  -- also why does it print "no mapping found" the first time to begin with
  -- TODO: test framework
  -- TODO: notes framework
  -- TODO: which-key
  -- TODO: hydra
  -- TODO: code runner framework
  -- TODO: buffer switcher?
  -- TODO: easy motion?
  -- TODO: work with marks?
  -- TODO: work with registers?
  -- TODO: work with folds?
  -- TODO: some regex plugin?

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
-- # [[pluglns]]
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

-- https://github.com/tpope/vim-projectionist
-- use projectionist instead of altr
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
