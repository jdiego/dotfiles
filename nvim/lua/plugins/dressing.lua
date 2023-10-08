-- Neovim plugin to improve the default vim.ui interfaces 
local M = {
    "stevearc/dressing.nvim",
    lazy = true,
}


function M.config()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
    end
end

return M