if not vim.g.vscode then

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "marksman",
    "terraformls",
    "tsserver",
    "vimls",
    "yamlls",
  },
  automatic_installation = true,
})

require('lspconfig')['bashls'].setup {
    on_attach = on_attach,
}
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
}
require('lspconfig')['terraformls'].setup{
    on_attach = on_attach,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
}
require('lspconfig')['vimls'].setup {
    on_attach = on_attach,
}
require('lspconfig')['yamlls'].setup {
    on_attach = on_attach,
}

end
