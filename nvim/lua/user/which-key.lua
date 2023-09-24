-- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings 
-- of the command you started typing.
local M = {
    "folke/which-key.nvim",
    commit = "5224c261825263f46f6771f1b644cae33cd06995",
    event = "VeryLazy",
}
  
function M.config()
    require("which-key").setup {}
end
  
return M