local M = {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    opts = {
        inlay_hints = {
            inline = false,
        },
        ast = {
            --These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },
            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
        },
    },
}

function M.config()
    clangd = require("clangd_extensions") 
    clangd.setup()
end
return M