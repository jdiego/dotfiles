-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright'}

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
    ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require("clangd_extensions").setup()
