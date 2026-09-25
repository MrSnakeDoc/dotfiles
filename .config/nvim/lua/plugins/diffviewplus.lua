return {
  "dlyongemallo/diffview-plus.nvim",

  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFileHistory",
  },

  keys = {
    { "<leader>ga", "<cmd>DiffviewOpen<cr>", desc = "Git Diffview" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Project History" },
  },

  opts = {
    enhanced_diff_hl = true,
    watch_index = true,
    wrap_entries = true,
    clean_up_buffers = true,

    view = {
      default = {
        layout = "diff2_horizontal",
        disable_diagnostics = false,
        winbar_info = false,
        focus_diff = false,
      },

      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
        winbar_info = true,
        focus_diff = true,
      },

      file_history = {
        layout = "diff2_horizontal",
        disable_diagnostics = false,
        winbar_info = false,
        focus_diff = false,
      },
    },

    file_panel = {
      listing_style = "tree",

      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },

      win_config = {
        position = "left",
        width = 35,
      },
    },

    file_history_panel = {
      win_config = {
        position = "bottom",
        height = 15,
      },

      date_format = "relative",
    },
  },
}
