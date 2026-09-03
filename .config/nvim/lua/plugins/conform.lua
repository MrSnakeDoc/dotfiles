return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = {
          "goimports",
          "gofumpt",
        },

        lua = { "stylua" },

        yaml = {},
        yml = {},
        json = { "prettier" },
        markdown = { "prettier" },
      },

      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype

        if ft == "yaml" or ft == "yml" then
          return
        end

        return {
          timeout_ms = 500,
          lsp_fallback = false,
        }
      end,
    },
  },
}
