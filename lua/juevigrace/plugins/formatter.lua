return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "ts-standard", "standardjs", "prettier" },
				typescript = { "ts-standard", "standardjs", "prettier" },
				javascriptreact = { "ts-standard", "standardjs", "prettier" },
				typescriptreact = { "ts-standard", "standardjs", "prettier" },
				svelte = { "prettier" },
				astro = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
				go = { "gofumpt", "goimports" },
				kotlin = { "klint" },
				php = { "php-cs-fixer" },
				sql = { "sql-formatter" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
