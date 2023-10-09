local icons = require("config.icons")
local M = {
    "SmiteshP/nvim-navic",
    lazy = true,
    -- init = function()
    --     vim.g.navic_silence = true
    --     require("helpers").on_attach(function(client, buffer)
    --         if client.server_capabilities.documentSymbolProvider then
    --             require("nvim-navic").attach(client, buffer)
    --         end
    --     end)
    -- end,
    opts = {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = icons.kinds,
    }
}
return M