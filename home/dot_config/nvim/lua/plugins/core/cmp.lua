local plugins = require 'globals'.plugins

table.insert(plugins, {
  name = 'nvim-cmp',
  setup = function()
  end,
  config = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.opt.complete = {}

    local cmp = require 'cmp'

    local compare = require('cmp.config.compare')

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered{col_offset=-1},
        documentation = cmp.config.disable,
      },
      mapping = {
        -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-q>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm(),
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { 'i', 's', 'c' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s", "c" })
      },
      sources = {
        -- { name = 'cmp_tabnine', priority = 1000, max_item_count = 20 },
        { name = 'vsnip', priority = 900, max_item_count = 5 },
        { name = 'nvim_lsp', priority = 500, max_item_count = 20 },
        { name = 'nvim_lua', priority = 500, max_item_count = 20 },
        { name = 'buffer', priority=700, keyword_length=3, max_item_count=5  },
        { name = 'emoji' },
        { name = 'rg', priority = 500, keyword_length = 3, max_item_count = 5 },
        { name = 'calc', priority = 100 },
        -- { name = 'spell', priority=100 },
      },
      formatting = {
        format = require('lspkind').cmp_format({
          with_text = true,
          maxwidth = 50,
          menu = {
            -- cmp_tabnine = '[T9]',
            vsnip = '[VSNIP]',
            fuzzy_path = '[FZYPATH]',
            -- fuzzy_buffer = '[FZYBUF]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[LUA]',
            buffer = '[BUF]',
            rg = '[RG]',
            cmdline = '[CMD]',
            calc = '[CLC]',
            -- zsh = '[ZSH]',
            git = '[GIT]',
          },
        })
      },
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('cmp_fuzzy_path.compare'),
          -- require('cmp_fuzzy_buffer.compare'),
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({'/', '?'}, {
      sources = {
        { name = 'buffer', max_item_count = 30, },
        -- { name = 'fuzzy_buffer', max_item_count = 30, }
      }
    })
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'fuzzy_path', max_item_count = 20, option = {fd_timeout_msec = 1500} }
      }, {
        { name = 'cmdline', max_item_count = 30, }
      }),
    })
  end })

table.insert(plugins, {
  name = 'vim-vsnip',
  setup = function()
  end,
  config = function()
    -- local map = require 'utils'.map
    vim.g.vsnip_snippet_dir = vim.fn.expand("$XDG_CONFIG_HOME/nvim/snippets")

    vim.cmd[[
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]
  end })

-- table.insert(plugins, {
--   name = 'cmp-zsh',
--   setup = function()
--   end,
--   config = function()
--     require 'cmp_zsh'.setup {
--       filetypes = { 'sh', 'zsh' }
--     }
--   end })

table.insert(plugins, {
  name = 'cmp-git',
  setup = function()
  end,
  config = function()
    require 'cmp_git'.setup {}
  end })

-- table.insert(plugins, {
--   name = 'cmp-tabnine',
--   setup = function()
--   end,
--   config = function()
--     local tabnine = require('cmp_tabnine.config')
--     tabnine:setup({
--       max_lines = 1000;
--       max_num_results = 20;
--       sort = true;
--       run_on_every_keystroke = true;
--       snippet_placeholder = '..';
--     })
--   end })

table.insert(plugins, {
  name = 'cmp-cmdline',
  setup = function()
  end,
  config = function()
    local map = require 'utils'.map
    map('c', '<tab>', '<nop>')
    map('c', '<s-tab>', '<nop>')
    vim.opt.wildmenu = false
  end })

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/hrsh7th/nvim-cmp',
    requires = {
      {
        p 'https://github.com/hrsh7th/vim-vsnip',
        requires = {
          { p 'https://github.com/hrsh7th/vim-vsnip-integ', },
          { p 'https://github.com/rafamadriz/friendly-snippets', },
        },
      },
      { p 'https://github.com/onsails/lspkind-nvim', },
      { p 'https://github.com/hrsh7th/cmp-calc', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-vsnip', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-emoji', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-buffer', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', },
      -- { p 'https://github.com/hrsh7th/cmp-path', after = 'nvim-cmp', },
      { p 'https://github.com/lukas-reineke/cmp-rg', after = 'nvim-cmp', },
      -- { p 'https://github.com/f3fora/cmp-spell', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-cmdline', after = 'nvim-cmp', },
      -- { p 'https://github.com/tamago324/cmp-zsh', after = 'nvim-cmp', },
      -- { p 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp', },
      -- {
      --   p 'https://github.com/tzachar/cmp-tabnine',
      --   run = function()
      --     vim.pretty_print(
      --       vim.fn.system(
      --         vim.fn.stdpath('data') .. '/site/pack/packer/opt/cmp-tabnine/install.sh'
      --       )
      --     )
      --   end,
      --   after = 'nvim-cmp',
      -- },
    },
  }

  use {
    p 'https://github.com/petertriho/cmp-git',
    requires = {
      { p 'https://github.com/hrsh7th/nvim-cmp', },
      { p 'https://github.com/nvim-lua/plenary.nvim' },
    },
  }

  use { p 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make', }
  use {
    p 'https://github.com/tzachar/cmp-fuzzy-path',
    requires = {
      { p 'https://github.com/hrsh7th/nvim-cmp', },
      { p 'https://github.com/tzachar/fuzzy.nvim', },
    },
  }

  -- use {
  --   p 'https://github.com/tzachar/cmp-fuzzy-buffer',
  --   requires = {
  --     { p 'https://github.com/hrsh7th/nvim-cmp', },
  --     { p 'https://github.com/tzachar/fuzzy.nvim', },
  --   },
  -- }

end
return M
