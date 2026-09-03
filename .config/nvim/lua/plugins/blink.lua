return {
  {
    "saghen/blink.cmp",

    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },

        ghost_text = {
          enabled = true,
        },
      },

      keymap = {
        preset = "default",

        ["<Tab>"] = {
          "select_and_accept",
          "fallback",
        },

        ["<Esc>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.cancel()
              return true
            end
          end,
          "fallback",
        },
      },
    },
  },
}
