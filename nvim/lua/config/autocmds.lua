vim.api.nvim_create_autocmd( "LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", {clear=true}),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then return end
    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable( true, client_id, args.buf, {autotrigger = true} )
    end
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("cmp-sanitizer", {clear=true}),
  callback = function(args)
    -- If BufType is named (like TelescopePrompt)
    if vim.bo[args.buf].buftype ~= "" then
      -- Disable Autocomplete
      vim.bo[args.buf].autocomplete = false
    end
  end,
})
