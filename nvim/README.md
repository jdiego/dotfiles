## The Config Structure

The config structure is relatively simple

- init.lua: the entry point for your config
- lua/: the directory where all of your lua code and plugin config goes
- lua/user: a namespace to avoid collisions with other plugins and lua modules
- lua/user/lsp: lsp is complicated enough to warrant it's own separate directory
- lua/user/lsp/settings: specific settings for your Language Server, to find more settings for your language server
