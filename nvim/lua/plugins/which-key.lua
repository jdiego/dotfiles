local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}
  
function M.config()
    local opts = {
        defaults = {
            ["<leader>sn"] = { name = "+noice" }
        }
    }
    require("which-key").setup(opts)
end
  
return M