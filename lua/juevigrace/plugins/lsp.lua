return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        config = function()
            local cmp = require('cmp')
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

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
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
        "j-hui/fidget.nvim",
        opts = {}
    },
}
