local M = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
        },
    },
    build = ":MasonUpdate",
    keys = { 
        { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } 
    },
    settings = {
        ui = {
            border = "none",
            icons = {
                package_installed = "◍",
                package_pending = "◍",
                package_uninstalled = "◍",
            },
            },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    },
    opts = {
        ensure_installed = {
            "codelldb",
            "cmakelang"
        }
    },
    config = function(_, opts)
        local mason = require("mason")
        local lspconfig =require("mason-lspconfig")
        local servers = require("config.lsp.servers").servers
        mason.setup(opts)
        lspconfig.setup {
            -- A list of servers to automatically install if they're not already installed. 
            ensure_installed = servers,
            automatic_installation = true,
        }
        local mr = require("mason-registry")
        local function ensure_installed()
            for _, tool in pairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end
        if mr.refresh then
            mr.refresh(ensure_installed)
        else
            ensure_installed()
        end
    end
}
    
  
return M