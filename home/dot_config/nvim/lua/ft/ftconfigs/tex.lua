local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'tex'

add(g.lsp.fts, {
  ft,
  'latex',
  'bib',
})

add(g.lsp.servers.lsp_installer, {
  texlab = function(on_attach, capabilities)
    local util = require "lspconfig".util
    return {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      root_dir = util.root_pattern(".git"),
      settings = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          build = {
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            executable = "latexmk",
            forwardSearchAfter = false,
            onSave = true
          },
          chktex = {
            onEdit = false,
            onOpenAndSave = false
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          forwardSearch = {
            args = {}
          },
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = false
          }
        }
      }
    }
  end,
  ltex = function(on_attach, capabilities)
    return {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      -- delete this line to activate
      filetypes = {},
      settings = {
        ltex = {
          enabled = { "latex", "tex", "bib", "markdown" },
          language = "en",
          diagnosticSeverity = "information",
          setenceCacheSize = 2000,
          additionalRules = {
            enablePickyRules = true,
            motherTongue = { "en", "de" },
          },
          trace = { server = "verbose" },
          dictionary = {};
          disabledRules = {};
          hiddenFalsePositives = {};
        }
      }
    }
  end,
})

add(g.treesitter.ensure_installed, {
  'latex',
  'bibtex',
})

local configs = {}

configs[ft] = function()
  local optl = vim.opt_local
  local noremap = require 'utils'.noremap_buffer
  optl.spelllang = 'en,de'
  optl.spell = true

  -- " nnoremap <buffer> <silent> <leader>m :exec 'FloatermNew --autoclose=0 --disposable --width=0.95 --height=0.95 latexmk -pdf ' . resolve(expand('%'))<CR>
  noremap('n', '<leader>m', ':exec "vsplit ./latex/output/" . resolve(expand("%:t:r")) . ".log"<cr>')
  noremap('n', '<leader>n', ':call jobstart("zathura ./latex/output/" . resolve(expand("%:t:r")) . ".pdf", {"detach":1})<cr>')
end

vim.api.nvim_create_autocmd(
  {'Filetype'},
  {
    group = 'MyFt',
    pattern = { ft, },
    callback = configs[ft],
  }
)
