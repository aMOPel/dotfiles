local configs = {}

configs['nvim-lspconfig'] = function()
  -- mappings
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.setup {}
  local lspconfig = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- for k, v in pairs(client.resolved_capabilities) do
    --   print(k,v)
    -- end
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    if client.resolved_capabilities.declaration then
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    end
    if client.resolved_capabilities.goto_definition then
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end
    if client.resolved_capabilities.implementation then
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    end
    if client.resolved_capabilities.find_references then
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    end
    if client.resolved_capabilities.hover then
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end
    if client.resolved_capabilities.signature_help then
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('i', '<C-k>', '<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    end
    if client.resolved_capabilities.type_definition then
      buf_set_keymap('n', '<space>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end
    if client.resolved_capabilities.rename then
      buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    end
    if client.resolved_capabilities.code_action then
      buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
    if client.resolved_capabilities.workspace_symbol then
      buf_set_keymap('n', '<space>lS', '<cmd>lua vim.lsp.buf.workspace_symbol("")<CR>', opts)
    end
    if client.resolved_capabilities.document_symbol then
      buf_set_keymap('n', '<space>ls', '<cmd>lua vim.lsp.buf.document_symbol("")<CR>', opts)
    end
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    -- if client.resolved_capabilities.document_range_formatting then
    --   buf_set_keymap("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- end

    -- TODO add move to quickfix after document_symbol
    -- TODO change codeAction to work with completion menu, and to autoselect, if theres only one choice
    -- vim.lsp.handlers["textDocument/codeAction"] = my_custom_default_definition

    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>lq', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)


    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      hi LspReferenceRead  cterm=underline term=underline gui=underline
      hi LspReferenceText  cterm=underline term=underline gui=underline
      hi LspReferenceWrite cterm=underline term=underline gui=underline
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] , false)
    end
  end

  -------------------------------------------------------------------
  -- snippets

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true;
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  -------------------------------------------------------------------
  -- Include the servers you want to have installed by default below
  local g = require 'globals'
  local servers = g.lsp.servers

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        print("Installing " .. name)
        server:install()
      end
    end
  end

  local add_on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end

  for _, server in pairs(servers) do
    local opts = {}

    if (server == "eslint") then
      opts = {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = true
          on_attach(client, bufnr)
        end,
        settings = {
          format = { enable = true },
        },
        flags = {
          debounce_text_changes = 500,
        }
      }
    elseif (server == "jsonls") then
      opts = {
        filetypes = { "json" },
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      }
    elseif (server == "volar") then
      opts = {
        init_options = {
          languageFeatures = {
            diagnostics = false,
          }
        },
        on_attach = add_on_attach,
        settings = {
          tsPlugin = true;
        },
      }
    elseif (server == "tsserver") then
      opts = {
        capabilities = capabilities,
        handlers = { ['textDocument/publishDiagnostics'] = function(...) end },
        on_attach = add_on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    elseif (server == "html") then
      opts = {
        filetypes = { "html" },
        capabilities = capabilities,
        on_attach = add_on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    elseif (server == "css") then
      opts = {
        filetypes = { "css" },
        capabilities = capabilities,
        on_attach = add_on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    elseif (server == "tailwindcss") then
      opts = {
        filetypes = { "html", "vue", "css" },
        capabilities = capabilities,
        on_attach = add_on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    elseif (server == "sumneko_lua") then
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      opts = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
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
    elseif (server == 'texlab') then
      local util = require "lspconfig".util
      opts = {
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
    elseif (server == 'ltex') then
      opts = {
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
    else
      opts = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end

    if (opts["capabilities"] ~= nil) then
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(opts.capabilities)
    else
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end

    lspconfig[server].setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end

  -------------------------------------------------------------------
  -- gdscript

  lspconfig.gdscript.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local g = require 'globals'
local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/neovim/nvim-lspconfig',
    requires = {
      { 'cmp-nvim-lsp' },
      { p 'https://github.com/williamboman/nvim-lsp-installer' },
      {
        p 'https://gitlab.com/yorickpeterse/nvim-dd',
        config = function() require('dd').setup { timeout = 1000, } end
      },
      { p 'https://github.com/j-hui/fidget.nvim' },
      { p 'https://github.com/b0o/SchemaStore.nvim' },
    },
    config = configs['nvim-lspconfig'],
    ft = g.lsp.fts,
  }

end
return M
