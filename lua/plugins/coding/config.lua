local config = {}

function config.cmp()
	return function(_, opts)
		local cmp = require("cmp")
		local t = function(str)
			return vim.api.nvim_replace_termcodes(str, true, true, true)
		end
		local has_words_before = function()
			local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		local border = function(hl)
			return {
				{ "╭", hl },
				{ "─", hl },
				{ "╮", hl },
				{ "│", hl },
				{ "╯", hl },
				{ "─", hl },
				{ "╰", hl },
				{ "│", hl },
			}
		end
		local lspkind = require("lspkind")
		return {
			window = {
				completion = {
					border = border("Normal"),
					max_width = 80,
					max_height = 20,
				},
				documentation = {
					border = border("CmpDocBorder"),
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						-- symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. strings[1] .. " "
					kind.menu = "    (" .. strings[2] .. ")"
					return kind
				end,
			},
			-- formatting = {
			-- 	format = function(_, item)
			-- 		local icons = require("config").icons.kinds
			-- 		if icons[item.kind] then
			-- 			item.kind = icons[item.kind] .. item.kind
			-- 		end
			-- 		return item
			-- 	end,
			-- },
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.close(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					keyword_length = 2,
					max_item_counts = 32,
				},
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "spell" },
				{ name = "latex_symbols" },
			}),
			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
		}
	end
end

function config.surround()
	return {
		mappings = {
			add = "gza", -- Add surrounding in Normal and Visual modes
			delete = "gzd", -- Delete surrounding
			find = "gzf", -- Find surrounding (to the right)
			find_left = "gzF", -- Find surrounding (to the left)
			highlight = "gzh", -- Highlight surrounding
			replace = "gzr", -- Replace surrounding
			update_n_lines = "gzn", -- Update `n_lines`
		},
	}
end

return config
