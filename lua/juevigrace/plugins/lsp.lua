return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "j-hui/fidget.nvim",
        },
        config = function()
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "templ",
                    "pyright",
                    "jdtls",
                    "kotlin_language_server",
                    "gradle_ls",
                    "cssls",
                    "html",
                    "htmx",
                    "tailwindcss",
                    "eslint",
                    "jsonls",
                    "intelephense",
                    "dockerls",
                    "docker_compose_language_service",
                    "sqls",
                    "harper_ls",
                    "yamlls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                    gopls = function()
                        local lspconfig = require("lspconfig")
                        local util = require "lspconfig/util"

                        lspconfig.gopls.setup {
                            capabilities = capabilities,
                            cmd = { "gopls" },
                            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                            settings = {
                                completeUnimported = true
                            }
                        }
                    end
                }
            })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {}
    },
}
