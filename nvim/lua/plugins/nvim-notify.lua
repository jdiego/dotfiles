-- A fancy, configurable, notification manager for NeoVim
local M = {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
        {
            "<leader>un",
            function() require("notify").dismiss({ silent = true, pending = true }) end,
            desc = "Dismiss all Notifications",
        },
    },
    opts = {
        timeout = 3000,
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },

}
function M.init()
    vim.notify = require("notify")
end

return M