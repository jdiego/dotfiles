-- (Neo)Vim plugin for automatically highlighting other uses of the word 
-- under the cursor using either LSP, Tree-sitter, or regex matching. 

local M = {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },    
    opts = {
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
    },
    keys = {
        { "]]", desc = "Next Reference" },
        { "[[", desc = "Prev Reference" },
    },
}
  
function M.config()
    local illuminate = require "illuminate"
    vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
    vim.api.nvim_set_keymap(
        "n",
        "<a-n>",
        '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
        { noremap = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<a-p>",
        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
        { noremap = true }
    )
  
    illuminate.configure {
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        delay = 200,
        filetypes_denylist = {
            "dirvish",
            "fugitive",
            "alpha",
            "NvimTree",
            "packer",
            "neogitstatus",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
    }
    local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
            require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end
    map("]]", "next")
    map("[[", "prev")

    -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
    vim.api.nvim_create_autocmd("FileType", {
        callback = function()
            local buffer = vim.api.nvim_get_current_buf()
            map("]]", "next", buffer)
            map("[[", "prev", buffer)
        end,
    })
end
  
return M