----------------------------------------------------------------
-- Plugin manager configuration file
-- automatically install Lazy 
----------------------------------------------------------------
-- directory where plugins will be installed
local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        install_path,
    })
end
vim.opt.rtp:prepend(install_path)
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\"

-- load lazy
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { 
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { require("plugins.colorscheme").name } 
    },
    defaults = { 
        -- should plugins be lazy-loaded ?
        lazy = true,
        autocmds = true, -- config.autocmds
        keymaps = true, -- config.keymaps
    },
    ui = { 
        wrap = "true" -- wrap the lines in the ui
    },
    change_detection = { 
        enabled = true,     -- automatically check for config file changes and reload the ui
        notify = true,      -- get a notification when changes are found
    },
    debug = false,
    performance = {
    rtp = {
        disabled_plugins = {
            -- "gzip",            -- Plugin for editing compressed files.
            -- "matchit",         -- What is it?
            --  "matchparen",     -- Plugin for showing matching parens
            --  "netrwPlugin",    -- Handles file transfers and remote directory listing across a network
            --  "tarPlugin",      -- Plugin for browsing tar files
            --  "tohtml",         -- Converting a syntax highlighted file to HTML
            --  "tutor",          -- Teaching?
            --  "zipPlugin",      -- Handles browsing zipfiles
        },
    },
  },
})