-- A blazing fast and easy to configure Neovim statusline written in Lua.
local M = {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
    local icons = require("config").icons
    local helpers = require("helpers")
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
        return
    end
  
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
  
    local filetype = {
        "filetype",
        icons_enabled = false,
    }
  
    local location = {
        "location",
        padding = 0,
    }
  
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
                -- stylua: ignore
                {
                    function() return require("nvim-navic").get_location() end,
                    cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
                },
            },
            lualine_x = { 
                diff, 
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

            },
            lualine_y = { location },
            lualine_z = { "progress" },
        },
        extensions = { "neo-tree", "lazy" },
    }
end
  
return M