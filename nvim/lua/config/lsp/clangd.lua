return {
    opts = {
        keys = {
            { 
                "<leader>cR", 
                "<cmd>ClangdSwitchSourceHeader<cr>", 
                desc = "Switch Source/Header (C/C++)" 
            },
        },
        root_dir = function(fname)
            local makefiles_files = {
                "Makefile", "configure.ac", "configure.in", "config.h.in", 
                "meson.build", "meson_options.txt", "build.ninja"
            }
            local compile_files = "compile_commands.json", "compile_flags.txt"
            return  require("lspconfig.util").root_pattern(makefiles_files)(fname) or 
                    require("lspconfig.util").root_pattern(compile_files)(fname) or 
                    require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = { offsetEncoding = { "utf-16" },}, 
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        },
        init_options = {usePlaceholders = true, completeUnimported = true, clangdFileStatus = true, },
    },
    on_attach = function ()
       require("clangd_extensions.inlay_hints").setup_autocmd()
       require("clangd_extensions.inlay_hints").set_inlay_hints()
    end
}