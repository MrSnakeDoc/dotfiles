-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")

vim.api.nvim_set_hl(0, "CursorNormal", {
  fg = "#000000",
  bg = "#FFFFFF",
})

vim.api.nvim_set_hl(0, "CursorInsert", {
  fg = "#000000",
  bg = "#FFFFFF",
})

vim.api.nvim_set_hl(0, "CursorReplace", {
  fg = "#000000",
  bg = "#FF5555",
})

vim.opt.guicursor = table.concat({
  "n-v-c:block-CursorNormal/lCursor",
  "i-ci-ve:ver25-CursorInsert/lCursor",
  "r-cr:hor20-CursorReplace/lCursor",
  "o:hor50-CursorNormal/lCursor",
}, ",")
