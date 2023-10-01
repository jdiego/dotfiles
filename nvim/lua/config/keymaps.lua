-----------------------------------------------------------
-- Key mapping configuration file
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-----------------------------------------------------------
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }


-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)

keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
