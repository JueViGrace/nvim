return {
  --
  -- 	-- NOTE: Plugins can specify dependencies.
  -- 	--
  -- 	-- The dependencies are proper plugin specifications as well - anything
  -- 	-- you do for a plugin at the top level, you can do for a dependency.
  -- 	--
  -- 	-- Use the `dependencies` key to specify the dependencies of a particular plugin
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  { "j-hui/fidget.nvim", opts = {} },
  {
    "mfussenegger/nvim-dap",
  },
  -- {
  --   "scalameta/nvim-metals",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "j-hui/fidget.nvim",
  --     "mfussenegger/nvim-dap",
  --   },
  --   ft = { "scala", "java", "sbt", "kotlin", "kt", "kts" },
  --   opts = function()
  --     local metals_config = require("metals").bare_config()
  --
  --     -- Example of settings
  --     metals_config.settings = {
  --       showImplicitArguments = true,
  --       excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  --     }
  --
  --     -- *READ THIS*
  --     -- I *highly* recommend setting statusBarProvider to either "off" or "on"
  --     --
  --     -- "off" will enable LSP progress notifications by Metals and you'll need
  --     -- to ensure you have a plugin like fidget.nvim installed to handle them.
  --     --
  --     -- "on" will enable the custom Metals status extension and you *have* to have
  --     -- a have settings to capture this in your statusline or else you'll not see
  --     -- any messages from metals. There is more info in the help docs about this
  --     metals_config.init_options.statusBarProvider = "on"
  --
  --     -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
  --     metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     metals_config.on_attach = function(client, bufnr)
  --       require("metals").setup_dap()
  --     end
  --
  --     return metals_config
  --   end,
  --   config = function(self, metals_config)
  --     local metals = require("metals")
  --     local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = self.ft,
  --       callback = function()
  --         require("metals").initialize_or_attach(metals_config)
  --       end,
  --       group = nvim_metals_group,
  --     })
  --
  --     vim.keymap.set("n", "<leader>mc", function()
  --       require("telescope").extensions.metals.commands()
  --     end, { desc = "Metals Commands" })
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        bashls = {},
        clangd = {},
        gopls = {},
        templ = {},
        pyright = {},
        sqlls = {},
        gradle_ls = {},
        kotlin_lsp = {
          -- filetypes = { "kotlin", "kt", "kts" },
          -- root_dir = function(fname)
          --   return require("lspconfig.util").root_pattern(
          --     "settings.gradle.kts",
          --     "settings.gradle",
          --     "build.gradle.kts",
          --     "build.gradle",
          --     "pom.xml"
          --   )(fname)
          -- end,
        },
        jdtls = {},
        dcm = {},
        html = {},
        htmx = {},
        cssls = {},
        tailwindcss = {},
        svelte = {},
        astro = {},
        jsonls = {},
        yamlls = {},
        dockerls = {},
        docker_compose_language_service = {},
        -- nil_ls = {},
        -- harper_ls = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        ts_ls = {},
        hyprls = {},
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters
        "stylua", -- Used to format Lua code
        "black",
        "prettier",
        "prettierd",
        "ktfmt",
        "google-java-format",
        "goimports",
        "clang-format",
        "sqlfmt",
        "yamlfmt",
        "alejandra",
        "shfmt",

        -- DAPs
        "bash-debug-adapter",
        "kotlin-debug-adapter",
        "debugpy",
        "js-debug-adapter",
        "delve",
        "dart-debug-adapter",
        "cpptools",

        -- Linters
        "shellcheck",
        "luacheck",
        "pylint",
        "sqlfluff",
        "eslint_d",
        "yamllint",
        "jsonlint",
        "htmlhint",
        "stylelint",
        "cpplint",
        "hadolint",
        "checkmake",

        -- Formatters/Linters
        "ktlint",
        "dcm",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "j-hui/fidget.nvim",
      -- Useful status updates for LSP.

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })
    end,
  },
}
