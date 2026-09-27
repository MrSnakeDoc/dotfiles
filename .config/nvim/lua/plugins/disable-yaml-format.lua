return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        yamlls = function(_, opts)
          opts.capabilities = opts.capabilities or {}

          opts.capabilities.documentFormattingProvider = false
          opts.capabilities.documentRangeFormattingProvider = false

          require("lspconfig").yamlls.setup({
            settings = {
              yaml = {
                format = {
                  enable = false,
                },
              },
            },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          })

          return true
        end,
      },
    },
  },
}
