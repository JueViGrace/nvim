return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			notify_on_error = true,
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				-- astro = { "prettier" },
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
			formatters = {
				prettier = {
					stdin = true,
					command = "prettier",
					args = {
						"--no-color",
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
					},
					cwd = require("conform.util").root_file({
						".prettierrc.json",
						".prettierrc",
						".prettierrc.mjs",
						"prettier.config.js",
					}),
					inherit = true,
					prepend_args = { "--use-tabs" },
					append_args = { "--trailing-comma" },
				},
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
