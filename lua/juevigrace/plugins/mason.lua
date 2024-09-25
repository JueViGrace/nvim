return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "luaformatter",
                "shfmt",
                "detekt",
                "luacheck",
                "phpcs",
                "pylint",
                "ts-standard",
                "yamllint",
                "black",
                "ktlint",
                "php-cs-fixer",
                "prettier",
                "sqlfluff",
                "standardjs",
                "js-debug-adapter",
                "java-debug-adapter",
                "java-test",
                "gopls",
                "goimports",
                "gofumpt",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
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
                }
            })
        end
    }
}
