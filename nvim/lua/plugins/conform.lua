local M =  {
    'stevearc/conform.nvim',
    cmd = "ConformInfo",
    ependencies = { "mason.nvim" },
    lazy = true,
    opts = {},
    keys = {
        {
            "<leader>cF",
            function()
                require("conform").format({ formatters = { "injected" } })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },
}

function M.config()
    require("conform").setup({
        format = {
            timeout_ms = 1000,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettierd", "prettier" } },
        },
    })
    
    
end

return M