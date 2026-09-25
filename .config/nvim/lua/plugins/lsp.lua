local has_go = vim.fn.executable("go") == 1

local servers = {
  yamlls = {
    mason = false,
    init_options = {
      provideFormatter = false,
    },
  },
}

local ensure_installed = {
  "taplo",
  "marksman",
}

if has_go then
  servers.gopls = {
    settings = {
      gopls = {
        gofumpt = false,
      },
    },
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }

  table.insert(ensure_installed, "gopls")
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = servers,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = ensure_installed,
    },
  },
}
