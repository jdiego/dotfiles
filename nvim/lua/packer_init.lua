-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Automatically install packer
local fn = vim.fn
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer_init.lua source <afile> | PackerSync
    augroup end
]]


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Install plugins
return packer.startup(function(use)
    -- Add you plugins here:
    use 'wbthomason/packer.nvim'                -- packer can manage itself
    use 'williamboman/mason.nvim'               -- Manage external editor tooling i.e LSP servers
    use 'williamboman/mason-lspconfig.nvim'     -- Automatically install language servers to stdpath
    use 'neovim/nvim-lspconfig'                 -- Collection of configurations for built-in LSP client
    -- clang lsp extension
    use 'p00f/clangd_extensions.nvim'
    -- auto complete
    use 'hrsh7th/cmp-nvim-lsp'                  -- source for nvim builtin LSP client
    use 'hrsh7th/cmp-buffer'                    -- source for buffer words
    use 'hrsh7th/cmp-path'                      -- source for path
    use 'hrsh7th/cmp-cmdline'                   -- source for cmdline
    use 'hrsh7th/nvim-cmp'                      -- A completion plugin for neovim coded in Lua.

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Color schemes
    use 'navarasu/onedark.nvim'
    use 'tanvirtin/monokai.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstrap then
        require('packer').sync()
    end
end)


