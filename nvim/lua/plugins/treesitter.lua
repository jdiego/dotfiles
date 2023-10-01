 -- Treesitter is a new parser generator tool that we can
-- use in Neovim to power faster and more accurate
-- syntax highlighting.
local M = {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
        },
        {
            "nvim-tree/nvim-web-devicons",
            event = "VeryLazy",
        },
    },
    cmd = { "TSUpdateSync" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
    },
}

function M.config()
    local treesitter = require "nvim-treesitter"
    local configs = require "nvim-treesitter.configs"
    configs.setup {
        ensure_installed = { -- put the language you want in this array
            "c", "cpp", "rust", "cmake", 
            "lua", "python",
            "dockerfile", "yaml",
            "bash", "vim"
        },
        ignore_install = { "" },                                                       -- List of parsers to ignore installing
        sync_install = false,                                                          -- install languages synchronously (only applied to `ensure_installed`)
    
        highlight = {
            enable = true,       -- false will disable the whole extension
            disable = { "css" }, -- list of language that will be disabled
        },
        autopairs = {
            enable = true,
        },
        indent = { enable = true, disable = { "python", "css" } },
    
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    }
end


return M