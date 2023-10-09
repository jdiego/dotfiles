local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { "BufReadPre",  "BufNewFile" },
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
        },
    }, 
}

function M.config()
    local cmp_nvim_lsp = require "cmp_nvim_lsp" 
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits",},
    }
    capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
  
    local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
        keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
        keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    end
  
    local lspconfig = require "lspconfig"
    local on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        require("illuminate").on_attach(client)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
    end
  
    for _, server in pairs(require("config.lsp.servers").servers) do
        local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        server = vim.split(server, "@")[1]
        local require_ok, conf = pcall(require, "config.lsp." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", conf, opts)
            if conf.on_attach then
                opts.on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    conf.on_attach(client,bufnr)
                end
            end
        end
        lspconfig[server].setup(opts)
    end
  
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }
  
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
  
    local config = {
        -- disable virtual text
        virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
        },  
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            suffix = "",
        },
    }
    vim.diagnostic.config(config)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded",})
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded",})
    -- Enable rounded borders in :LspInfo window.
    require("lspconfig.ui.windows").default_options.border = "rounded"
    
end
  
return M
