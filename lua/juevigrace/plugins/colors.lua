function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "moon", -- auto, main, moon, or dawn
	-- 			dark_variant = "moon", -- main, moon, or dawn
	-- 			dim_inactive_windows = false,
	-- 			extend_background_behind_borders = true,
	--
	-- 			enable = {
	-- 				terminal = true,
	-- 				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
	-- 				migrations = true, -- Handle deprecated options automatically
	-- 			},
	--
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = true,
	-- 				transparency = true,
	-- 			},
	--
	-- 			groups = {
	-- 				border = "muted",
	-- 				link = "iris",
	-- 				panel = "surface",
	--
	-- 				error = "love",
	-- 				hint = "iris",
	-- 				info = "foam",
	-- 				note = "pine",
	-- 				todo = "rose",
	-- 				warn = "gold",
	--
	-- 				git_add = "foam",
	-- 				git_change = "rose",
	-- 				git_delete = "love",
	-- 				git_dirty = "rose",
	-- 				git_ignore = "muted",
	-- 				git_merge = "iris",
	-- 				git_rename = "pine",
	-- 				git_stage = "iris",
	-- 				git_text = "rose",
	-- 				git_untracked = "subtle",
	--
	-- 				h1 = "iris",
	-- 				h2 = "foam",
	-- 				h3 = "rose",
	-- 				h4 = "gold",
	-- 				h5 = "pine",
	-- 				h6 = "foam",
	-- 			},
	--
	-- 			before_highlight = function(group, highlight, palette)
	-- 				if highlight.italic then
	-- 					highlight.italic = false
	-- 				end
	-- 				if highlight.bold then
	-- 					highlight.bold = false
	-- 				end
	-- 				--
	-- 				-- Change palette colour
	-- 				-- if highlight.fg == palette.pine then
	-- 				--     highlight.fg = palette.foam
	-- 				-- end
	-- 			end,
	-- 		})
	--
	-- 		-- vim.cmd("colorscheme rose-pine")
	-- 		-- vim.cmd("colorscheme rose-pine-main")
	-- 		-- vim.cmd("colorscheme rose-pine-moon")
	-- 		-- vim.cmd("colorscheme rose-pine-dawn")
	-- 		ColorMyPencils("rose-pine-moon")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = true, -- Force no italic
				no_bold = true, -- Force no bold
				no_underline = true, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = { "italic" },
					keywords = { "italic" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				integrations = {
					nvimtree = true,
					aerial = true,
					alpha = true,
					cmp = true,
					dashboard = true,
					flash = true,
					grug_far = true,
					gitsigns = true,
					headlines = true,
					illuminate = true,
					indent_blankline = { enabled = true },
					leap = true,
					lsp_trouble = true,
					mason = true,
					markdown = true,
					mini = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					navic = { enabled = true, custom_bg = "lualine" },
					neotest = true,
					neotree = true,
					noice = true,
					notify = true,
					semantic_tokens = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			ColorMyPencils("catppuccin")
		end,
	},
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	config = function()
	-- 		ColorMyPencils("gruvbox")
	-- 	end,
	-- },
}
