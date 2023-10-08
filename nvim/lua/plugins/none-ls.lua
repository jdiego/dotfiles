local M = {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, { nls.builtins.diagnostics.cmake_lint, })
    end,
}

return M