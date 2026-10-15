local group = vim.api.nvim_create_augroup("AutoSaveFormat", { clear = true })

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = group,
  callback = function(args)
    local buf = args.buf

    -- Ignore invalid buffers
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    -- Ignore special buffers
    local buftype = vim.bo[buf].buftype
    if buftype ~= "" then
      return
    end

    -- Ignore non-file buffers
    if vim.bo[buf].modifiable == false or vim.bo[buf].readonly then
      return
    end

    -- Save only modified buffers
    if not vim.bo[buf].modified then
      return
    end

    -- Format buffer
    require("conform").format({
      bufnr = buf,
      async = false,
      lsp_fallback = false,
    })

    -- Save
    vim.cmd("silent write")
  end,
})
