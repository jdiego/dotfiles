-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for 
-- tree-sitter in Neovim. 
-- Tree-sitter is a parser generator tool and an incremental parsing library.  It can build a 
-- concrete syntax tree for a source file and efficiently update the syntax tree  as the source 
-- file is edited.

local M = {
    "nvim-treesitter/nvim-treesitter",
    commit = "226c1475a46a2ef6d840af9caa0117a439465500",
    event = "BufReadPost",
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
            commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
        },
        {
            "nvim-tree/nvim-web-devicons",
            event = "VeryLazy",
        },
    },
}

function M.config()
    local treesitter = require "nvim-treesitter"
    local configs = require "nvim-treesitter.configs"
    configs.setup {
        ensure_installed = {  -- put the language you want in this array
            "c", "cpp", "python", "lua", "rust",
            "markdown", "markdown_inline", "bash",
        }, 
        -- ensure_installed = "all", -- one of "all" or a list of languages
        ignore_install = { "" },      -- List of parsers to ignore installing
        sync_install = false,         -- install languages synchronously (only applied to `ensure_installed`)
  
        highlight = {
            enable = true,       -- false will disable the whole extension
            disable = { "css" }, -- list of language that will be disabled
        },
        autopairs = { enable = true, },
        indent = { enable = true, disable = { "python", "css" } },
        context_commentstring = { enable = true, enable_autocmd = false, },
    }
end

return M
