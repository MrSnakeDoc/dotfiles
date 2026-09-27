local semantic = {
  structure = "#7C4DFF", -- func, if, return

  type_keyword = "#FFFF07", -- type
  type = "#FFFF00", -- CheckerController, VersionInfo

  field = "#40C4FF", -- Config, HTTPClient

  function_name = "#64FFDA", -- Execute, Debug, checkUpdate

  parameter = "#FF6E40", -- ctx, checkOnly
  variable = "#FFAB38", -- state, resp, err

  builtin_type = "#FF4081", -- bool, error
  builtin_value = "#FF5252", -- nil

  operator = "#76FF03", -- ||, :=, ==, >=
}

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    opts = {
      flavour = "mocha",

      background = {
        dark = "mocha",
      },

      transparent_background = false,

      styles = {
        comments = { "italic" },
      },

      color_overrides = {
        mocha = {
          -- Absolute black space background
          base = "#010109",
          mantle = "#010109",
          crust = "#000000",

          -- Stronger surfaces
          surface0 = "#11111b",
          surface1 = "#1a1b26",
          surface2 = "#24283b",

          -- Better structure visibility
          overlay0 = "#6b7089",
          overlay1 = "#7f849c",
          overlay2 = "#9399b2",

          -- Bright text
          text = "#d9e0ee",
          subtext1 = "#bac2de",
          subtext0 = "#a6adc8",

          -- Dark azure inspired accents
          -- azure = "#B388FF",
          azure = "#40c4ff",
          blue = "#40C4FF",
          teal = "#64FFDA",
          yellow = "#FFFF8D",
          peach = "#FFAB40",
        },
      },

      custom_highlights = function(colors)
        return {
          -- Main editor
          Normal = {
            bg = "#010109",
          },

          NormalFloat = {
            bg = "#0a0a12",
          },

          FloatBorder = {
            fg = colors.azure,
            bg = "#0a0a12",
          },

          -- Comments
          Comment = {
            fg = "#7C8A9A",
            italic = true,
          },

          -- Line numbers
          LineNr = {
            fg = "#7f849c",
          },

          CursorLineNr = {
            fg = "#ffffff",
            bold = true,
          },

          -- Cursor line
          CursorLine = {
            bg = "#11131A",
          },

          CursorColumn = {
            bg = "#11131A",
          },

          -- Splits
          WinSeparator = {
            fg = colors.azure,
          },

          VertSplit = {
            fg = colors.azure,
          },

          -- Visual selection
          Visual = {
            bg = "#2A2E44",
          },

          -- Search
          Search = {
            bg = colors.azure,
            fg = "#ffffff",
          },

          IncSearch = {
            bg = "#7C4DFF",
            fg = "#ffffff",
          },

          -- Telescope / Snacks vibes
          TelescopeBorder = {
            fg = colors.azure,
          },

          TelescopePromptBorder = {
            fg = "#7C4DFF",
          },

          -- Indent guides
          IblIndent = {
            fg = "#2A2E39",
          },

          IblScope = {
            fg = colors.azure,
          },

          -- Treesitter / Go semantic colors
          ["@keyword.function"] = {
            fg = semantic.structure,
            italic = true,
          },

          ["@keyword.conditional.go"] = {
            fg = semantic.structure,
            italic = true,
          },

          ["@keyword.return.go"] = {
            fg = semantic.structure,
            italic = true,
          },

          ["@keyword.type"] = {
            fg = semantic.type_keyword,
          },

          ["@type"] = {
            fg = semantic.type,
          },

          ["@type.definition"] = {
            fg = semantic.type,
          },

          ["@property"] = {
            fg = semantic.field,
          },

          ["@variable.member"] = {
            fg = semantic.field,
          },

          ["@module"] = {
            fg = semantic.type,
          },

          ["@operator.go"] = {
            fg = semantic.operator,
          },

          ["@constant.builtin.go"] = {
            fg = semantic.builtin_value,
          },

          ["@function"] = {
            fg = semantic.function_name,
          },

          ["@function.call"] = {
            fg = semantic.function_name,
          },

          ["@function.method"] = {
            fg = semantic.function_name,
          },

          ["@function.method.call"] = {
            fg = semantic.function_name,
          },

          ["@variable.parameter"] = {
            fg = semantic.parameter,
          },

          ["@variable"] = {
            fg = semantic.variable,
          },

          ["@constant.builtin"] = {
            fg = semantic.builtin_value,
          },

          ["@type.builtin"] = {
            fg = semantic.builtin_type,
          },
        }
      end,

      integrations = {
        blink_cmp = true,
        snacks = true,
        noice = true,
        notify = true,
        mason = true,
        telescope = true,
        which_key = true,
        gitsigns = true,
        treesitter = true,
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
