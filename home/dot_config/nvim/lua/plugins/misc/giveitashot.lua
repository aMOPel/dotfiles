local plugins = require("globals").plugins

-- table.insert(plugins, {
--       name = 'cybu.nvim',
--       setup = function()
--       end,
--       config = function()
--       require("cybu").setup({
--         position = {
--           relative_to = "win",          -- win, editor, cursor
--           anchor = "center",         -- topleft, topcenter, topright,
--                                           -- centerleft, center, centerright,
--                                           -- bottomleft, bottomcenter, bottomright
--           vertical_offset = 0,         -- vertical offset from anchor in lines
--           horizontal_offset = 0,        -- vertical offset from anchor in columns
--           max_win_height = 10,           -- height of cybu window in lines
--           max_win_width = 0.5,          -- integer for absolute in columns
--                                           -- float for relative to win/editor width
--         },
--         style = {
--           path = "relative",            -- absolute, relative, tail (filename only)
--           border = "rounded",           -- single, double, rounded, none
--           separator = " ",              -- string used as separator
--           prefix = "…",                 -- string used as prefix for truncated paths
--           padding = 2,                  -- left & right padding in number of spaces
--           hide_buffer_id = true,        -- hide buffer IDs in window
--           devicons = {
--             enabled = true,             -- enable or disable web dev icons
--             colored = true,             -- enable color for web dev icons
--             truncate = false,            -- truncate wide icons to one char width
--           },
--           highlights = {                -- see highlights via :highlight
--             current_buffer = "CybuFocus",       -- current / selected buffer
--             adjacent_buffers = "CybuAdjacent",  -- buffers not in focus
--             background = "CybuBackground",      -- window background
--             border = "CybuBorder",              -- border of the window
--           },
--         },
--         behavior = {                    -- set behavior for different modes
--           mode = {
--             default = {
--               switch = "on_close",     -- immediate, on_close
--               view = "paging",         -- paging, rolling
--             },
--             last_used = {
--               switch = "on_close",      -- immediate, on_close
--               view = "paging",          -- paging, rolling
--             },
--           },
--         },
--         display_time = 1500,             -- time the cybu window is displayed
--         exclude = {                     -- filetypes, cybu will not be active
--           "neo-tree",
--           "fugitive",
--           "qf",
--         },
--     })
--     local map = require 'utils'.map
--     map('n', '\\', '<Plug>(CybuPrev)')
--     map('n', '\'', '<Plug>(CybuNext)')
--     -- map({'n', 'v'}, '<tab>', '<plug>(CybuLastusedPrev)')
--     -- map({'n', 'v'}, '<cr>', '<plug>(CybuLastusedNext)')
--     vim.cmd[[
--     highlight CybuFocus cterm=bold gui=bold guifg=#abb2bf guibg=#31353f guisp=none
--     highlight CybuAdjacent cterm=reverse guifg=#5c6370 guibg=#31353f guisp=none
--     highlight CybuBackground cterm=reverse guifg=#5c6370 guibg=#31353f guisp=none
--     highlight CybuBorder cterm=reverse guifg=#5c6370 guibg=#31353f guisp=none
--     ]]
--   end,
-- })

table.insert(plugins, {
  name = 'live-command.nvim',
  setup = function()
  end,
  config = function()
    require("live-command").setup {
      commands = {
        Norm = { cmd = "norm" },
        Reg = {
          cmd = "norm",
          -- This will transform ":5Reg a" into ":norm 5@a"
          args = function(opts)
            return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
          end,
          range = "",
        },
        Global = { cmd = "g" },
      },
      defaults = {
        enable_highlighting = true,
        inline_highlighting = true,
        hl_groups = {
          insertion = "DiffAdd",
          deletion = "DiffDelete",
          change = "DiffChange",
        },
      },
      debug = false,
    }
  end,
})

local p = require("utils").p

local M = function(use)

  use {
    p "https://github.com/smjonas/live-command.nvim",
  }


  -- use { p "https://github.com/tpope/vim-dadbod", }
  -- use { p "https://github.com/kristijanhusak/vim-dadbod-ui", }

  -- DONE: fix <c-s> in gitcommit
  -- TODO: fix black git text
  -- DONE: fix <leader>l
  -- TODO: incorporate PackerUpdate --preview
  -- TODO: fix error with rg, something sets cmdheight=1, but what?
  -- TODO: fix error when closing zsh, probably due to change in zshrc
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
  -- use {
  --   p 'https://github.com/ghillb/cybu.nvim',
  -- }
  -- use {
  --   p 'https://github.com/dstein64/vim-startuptime',
  -- }
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
