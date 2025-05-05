return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2000,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { "prettier", "prettierd" },
      typescript = { "prettier", "prettierd" },
      javascriptreact = { "prettier", "prettierd" },
      typescriptreact = { "prettier", "prettierd" },
      svelte = { "prettier", "prettierd" },
      astro = { "prettier", "prettierd" },
      css = { "prettier", "prettierd" },
      html = { "prettier", "prettierd" },
      json = { "prettier" },
      yaml = { "yamlfmt" },
      markdown = { "prettier", "prettierd" },
      -- Conform can also run multiple formatters sequentially
      nix = { "alejandra" },
      go = { "gofumpt", "goimports", stop_after_first = true },
      kotlin = { "ktlint" },
      java = { "google-java-format" },
      sql = { "sqlfmt" },
      cpp = { "clang_format" },
      dart = { "dcm" },
    },
  },
  config = function(_, opts)
    local conform = require("conform")

    local config = vim.tbl_deep_extend("force", opts, {
      formatters = {
        prettier = {
          require_cwd = true,
          cwd = require("conform.util").root_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }),
        },
      },
    })

    conform.setup(config)
  end,
}
