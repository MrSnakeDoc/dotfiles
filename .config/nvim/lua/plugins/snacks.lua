return {
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {
        size = 100 * 1024 * 1024,
        line_length = 100000,
      },
      picker = {
        hidden = true,
        ignored = true,

        exclude = {
          ".git",
        },

        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { ".git" },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = { ".git" },
          },
        },
      },
    },
  },
}
