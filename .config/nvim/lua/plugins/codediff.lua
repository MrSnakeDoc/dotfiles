return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",

  keys = {
    { "<leader>ga", "<cmd>CodeDiff<cr>", desc = "Git CodeDiff" },
    { "<leader>gh", "<cmd>CodeDiff history %<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>CodeDiff history<cr>", desc = "Project History" },
  },

  opts = {
    highlights = {
      line_insert = "DiffAdd",
      line_delete = "DiffDelete",

      -- Let CodeDiff derive the character-level colors
      -- from your colorscheme.
      char_insert = nil,
      char_delete = nil,
      char_brightness = nil,

      -- Keep conflict colors aligned with diagnostics/GitSigns.
      conflict_sign = nil,
      conflict_sign_resolved = nil,
      conflict_sign_accepted = nil,
      conflict_sign_rejected = nil,
    },

    diff = {
      -- Closest to the VS Code diff view you said you like.
      layout = "side-by-side",

      disable_inlay_hints = true,
      ignore_trim_whitespace = false,

      -- Old/original on the left, new/current on the right.
      original_position = "left",

      -- Conflict resolution:
      -- incoming/theirs left, current/ours right,
      -- resolved result underneath.
      conflict_ours_position = "right",
      conflict_result_position = "bottom",
      conflict_result_height = 30,

      -- Navigation should wrap instead of stopping at boundaries.
      cycle_next_hunk = true,
      cycle_next_file = true,

      -- Immediately show the interesting part when opening.
      jump_to_first_change = true,

      -- Cleaner than putting +/- everywhere.
      gutter_signs = false,

      -- Keep this off until you actually want moved-block detection.
      compute_moves = false,

      -- Normal view by default; toggle compact mode with `gc`.
      compact = false,
      compact_context_lines = 3,
      compact_sync_folds = true,
    },

    explorer = {
      position = "left",
      hidden = false,
      width = 35,

      auto_refresh = true,
      indent_markers = true,

      -- Same philosophy as your current Diffview panel:
      -- enter through the file list.
      initial_focus = "explorer",

      view_mode = "tree",
      flatten_dirs = true,

      file_filter = {
        ignore = {
          ".git/**",
          ".jj/**",
        },
      },

      untracked = "all",
      focus_on_select = false,

      visible_groups = {
        staged = true,
        unstaged = true,
        conflicts = true,
      },

      -- I would leave stats off initially.
      -- Nice feature, but not needed for the core experience.
      line_stats = {
        enabled = false,
      },
    },

    history = {
      position = "bottom",
      height = 15,
      initial_focus = "history",
      view_mode = "tree",
      date_format = "%ar",
    },

    keymaps = {
      view = {
        quit = "q",

        toggle_explorer = "<leader>b",
        focus_explorer = "<leader>e",

        next_hunk = "]c",
        prev_hunk = "[c",

        next_file = "]f",
        prev_file = "[f",

        -- Vimdiff semantics, still useful when you want them.
        diff_get = "do",
        diff_put = "dp",

        -- Stage / unstage.
        toggle_stage = "gs",
        stage_hunk = "<leader>hs",
        unstage_hunk = "<leader>hu",
        discard_hunk = "<leader>hr",

        -- Very useful:
        -- side-by-side <-> inline.
        toggle_layout = "t",

        -- Fold unchanged regions.
        toggle_compact = "gc",

        show_help = "g?",
      },

      explorer = {
        select = "<CR>",
        hover = "K",
        refresh = "R",

        toggle_view_mode = "i",

        stage_all = "gS",
        unstage_all = "U",
        restore = "X",

        toggle_changes = "gu",
        toggle_staged = "gT",
      },

      history = {
        select = "<CR>",
        toggle_view_mode = "i",
        refresh = "R",
      },

      conflict = {
        -- These are the ones I'd actually memorize.
        accept_incoming = "<leader>ct",
        accept_current = "<leader>co",
        accept_both = "<leader>cb",
        discard = "<leader>cx",

        next_conflict = "]x",
        prev_conflict = "[x",

        -- Whole-file variants remain available if needed.
        accept_all_incoming = "<leader>cT",
        accept_all_current = "<leader>cO",
        accept_all_both = "<leader>cB",
        discard_all = "<leader>cX",
      },
    },
  },
}
