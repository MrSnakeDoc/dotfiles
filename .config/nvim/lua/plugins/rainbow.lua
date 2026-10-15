return {
  {
    "HiPhish/rainbow-delimiters.nvim",

    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },

        query = {
          [""] = "rainbow-delimiters",
        },

        highlight = {
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterYellow",
          "RainbowDelimiterCyan",
        },
      }

      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", {
        fg = "#FF8A65",
      })

      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", {
        fg = "#BA68C8",
      })

      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", {
        fg = "#DCE775",
      })

      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", {
        fg = "#4DD0BF",
      })
    end,
  },
}
