-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("n", "<A-k>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-j>", ":m .-2<CR>==", { desc = "Move line up" })
map({ "n", "t" }, "<A-`>", function()
  Snacks.terminal.focus(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal Toggle" })
map({ "n", "t" }, "<leader>`", function()
  Snacks.terminal.focus(nil, {
    cwd = LazyVim.root(),
    win = {
      style = "float",
    },
  })
end, { desc = "Floating Terminal" })
map("n", "xx", '"_dd', { desc = "Delete line without yanking" })
map("v", "x", '"_d', { desc = "Delete selection without yanking" })
map("n", "<leader>aa", "ggVG", { desc = "Select full buffer" })
map("n", "<leader>al", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

-- Symbols movements
local enabled_languages = {
  go = true,
  rust = true,
  python = true,
  c = true,
  cpp = true,
  javascript = true,
  typescript = true,
}

local language_queries = {
  go = [[
    [
      (type_declaration)
      (function_declaration)
      (method_declaration)
    ] @symbol
  ]],

  rust = [[
    [
      (struct_item)
      (enum_item)
      (trait_item)
      (function_item)
    ] @symbol
  ]],

  python = [[
    [
      (class_definition)
      (function_definition)
    ] @symbol
  ]],

  c = [[
    [
      (function_definition)
      (struct_specifier)
      (enum_specifier)
    ] @symbol
  ]],

  cpp = [[
    [
      (function_definition)
      (class_specifier)
      (struct_specifier)
      (enum_specifier)
    ] @symbol
  ]],

  javascript = [[
    [
      (function_declaration)

      (lexical_declaration
        (variable_declarator
          value: (arrow_function)))

      (lexical_declaration
        (variable_declarator
          value: (function_expression)))

      (class_declaration)
    ] @symbol
  ]],

  typescript = [[
    [
      (function_declaration)

      (lexical_declaration
        (variable_declarator
          value: (arrow_function)))

      (lexical_declaration
        (variable_declarator
          value: (function_expression)))

      (class_declaration)

      (interface_declaration)
    ] @symbol
  ]],
}

local function get_symbols()
  local ft = vim.bo.filetype

  if not enabled_languages[ft] then
    return {}
  end

  local query_text = language_queries[ft]

  if not query_text then
    return {}
  end

  local ok, parser = pcall(vim.treesitter.get_parser, 0, ft)

  if not ok or not parser then
    return {}
  end

  local tree = parser:parse()[1]

  if not tree then
    return {}
  end

  local root = tree:root()

  local ok_query, query = pcall(vim.treesitter.query.parse, ft, query_text)

  if not ok_query or not query then
    return {}
  end

  local symbols = {}

  for _, node in query:iter_captures(root, 0) do
    local row = node:start()

    table.insert(symbols, {
      line = row + 1,
    })
  end

  table.sort(symbols, function(a, b)
    return a.line < b.line
  end)

  return symbols
end

local function jump_next_symbol()
  local current = vim.api.nvim_win_get_cursor(0)[1]

  for _, symbol in ipairs(get_symbols()) do
    if symbol.line > current then
      vim.api.nvim_win_set_cursor(0, { symbol.line, 0 })
      return
    end
  end
end

local function jump_prev_symbol()
  local current = vim.api.nvim_win_get_cursor(0)[1]

  local previous

  for _, symbol in ipairs(get_symbols()) do
    if symbol.line < current then
      previous = symbol
    else
      break
    end
  end

  if previous then
    vim.api.nvim_win_set_cursor(0, { previous.line, 0 })
  end
end

map("n", "]s", jump_next_symbol, {
  desc = "Next symbol",
})

map("n", "[s", jump_prev_symbol, {
  desc = "Previous symbol",
})

map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Outdent selection" })
