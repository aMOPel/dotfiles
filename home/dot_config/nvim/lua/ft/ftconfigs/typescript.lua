local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'typescript'

add(g.lsp.fts, {
  ft,
  'javascript',
})

add(g.lsp.servers.lsp_installer, {
  tsserver = function(on_attach, capabilities)
    local add_on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end
    return {
      capabilities = capabilities,
      handlers = { ['textDocument/publishDiagnostics'] = function(...) end },
      on_attach = add_on_attach,
    }
  end,
  eslint = function(on_attach, capabilities)
    return {
      on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = true
        on_attach(client, bufnr)
      end,
      settings = {
        format = { enable = true },
      },
    }
  end,
})

add(g.treesitter.ensure_installed, {
  ft,
  'javascript',
})
