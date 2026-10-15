return {
  {
    "MeanderingProgrammer/render-markdown.nvim",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },

    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = true,
          sign = false,

          icons = {
            "󰎤 ",
            "󰎧 ",
            "󰎪 ",
            "󰎭 ",
            "󰎱 ",
            "󰎳 ",
          },

          position = "inline",

          width = "full",

          border = false,

          left_pad = 1,
          right_pad = 1,
        },

        code = {
          enabled = true,

          sign = false,

          style = "full",

          position = "left",

          language = true,
          language_icon = true,
          language_name = true,

          width = "block",

          left_pad = 2,
          right_pad = 2,

          border = "thin",
        },

        bullet = {
          enabled = true,

          icons = {
            "●",
            "○",
            "◆",
            "◇",
          },

          left_pad = 0,
          right_pad = 1,
        },

        checkbox = {
          enabled = true,

          unchecked = {
            icon = "󰄱 ",
          },

          checked = {
            icon = "󰱒 ",
          },
        },

        quote = {
          enabled = true,

          icon = "▌",
        },

        pipe_table = {
          enabled = true,

          preset = "round",

          cell = "padded",

          padding = 1,
        },

        dash = {
          enabled = true,

          icon = "─",

          width = "full",
        },
      })
    end,
  },
}
