local provider = "clangd"
-- some settings can only passed as commandline flags, see `clangd --help`
local clangd_flags = {
    "--background-index",
    "--fallback-style=Google",
    "--all-scopes-completion",
    "--clang-tidy",
    "--log=error",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--pch-storage=memory", -- could also be disk
    "--folding-ranges",
    "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    -- NOTE: Workaround for "warning: multiple different client offset_encodings detected for buffer, this is not supported yet".
    -- Ref: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
    "--offset-encoding=utf-16", --temporary fix for null-ls
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)  
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
end


local custom_on_init = function()
    require("clangd_extensions").setup()
    -- require("lvim.lsp").common_on_init(client, bufnr)
    --require("clangd_extensions.config").setup {}
    --require("clangd_extensions.ast").init()
    vim.cmd [[
        command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
        command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
        command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
        command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
        command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
    ]]
end


local lsp_opts = {
    cmd = { provider, unpack(clangd_flags) },
    on_attach = custom_on_attach,
    on_init = custom_on_init,
}


return lsp_opts
