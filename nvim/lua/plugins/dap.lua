-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim

local M = {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
}
  
function M.config()
    local dap = require "dap"
  
    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
        return
    end
  
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
  
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
  
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
  
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
            command = "codelldb",
            args = { "--port", "${port}" },
            -- On windows you may have to uncomment this:
            -- detached = false,
        },
    }
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                local path
                vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
                    path = input
                end)
                vim.cmd [[redraw]]
                return path
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end
  
M = {
    "ravenxrz/DAPInstall.nvim",
    commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
    config = function()
        local dap_install =  require("dap_install")
        dap_install.setup {}
        dap_install.config("python", {})
        dap_install.config("codelldb",{})
    end,
}
  
return M