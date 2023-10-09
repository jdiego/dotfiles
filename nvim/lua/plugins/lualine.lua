-- A blazing fast and easy to configure Neovim statusline written in Lua.
local M = {
    "nvim-lualine/lualine.nvim",
    --event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        vim.o.laststatus = 0
    end,
}

function M.config()
    local icons = require("config.icons")
    local helpers = require("helpers")
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
        return
    end
    local navic = require("nvim-navic")
  
    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end
  
    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { 
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
        },
        colored = false,
        always_visible = true,
    }
  
    local diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
        cond = hide_in_width,
    }
    local filetype = {"filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }
    local location = { "location", padding = 0,  right = 1 }
    local filename = { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } }
    local progress = { "progress", separator = " ", padding = { left = 1, right = 0 } }
    local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end
    lualine.setup {
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = { 
                diagnostics,
                filetype,
                filename,
                -- stylua: ignore
                {
                    function() return require("nvim-navic").get_location() end,
                    cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
                },
            },
            lualine_x = { 
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = helpers.fg("Statement"),
                    
                },
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = helpers.fg("Constant"),
                },
                 {
                    function() return "  " .. require("dap").status() end,
                    cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = helpers.fg("Debug"),
                },
                { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = helpers.fg("Special") },
                diff, 
            },
            lualine_y = { progress, location },
            lualine_z = {
                function()
                  return " " .. os.date("%R")
                end,
            },
        },
        -- winbar = {
        --     lualine_c = {
        --         {   function() return navic.get_location() end, 
        --             cond = function() return navic.is_available() end
        --         },
        --     }
        -- },
        extensions = { "neo-tree", "lazy" },
    }
end
  
return M