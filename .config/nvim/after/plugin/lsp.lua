if not vim.g.vscode then

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '§', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '½', vim.diagnostic.goto_next, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  local common = {
    on_attach = on_attach,
  }

  local servers = {
    'bashls',
    'rust_analyzer',
    'terraformls',
    'ts_ls',
    'vimls',
  }

  for _, name in ipairs(servers) do
    vim.lsp.config(name, common)
    vim.lsp.enable(name)
  end

end
