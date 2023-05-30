local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
	local format = function()
		require("plugins.lsp.format").format({ force = true })
	end
	if not M._keys then
  ---@class PluginLspKeys
    -- stylua: ignore
    M._keys =  {
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "g]", M.diagnostic_goto(true), desc = "Next Diagnostic" },
      { "g[", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "<leader>gf", format, desc = "Format Document", has = "documentFormatting" },
      { "<leader>ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    }
	end
	return M._keys
end

function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

	for _, value in ipairs(M.get()) do
		local keys = Keys.parse(value)
		if keys[2] == vim.NIL or keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end

	for _, keys in pairs(keymaps) do
		if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
			local opts = Keys.opts(keys)
			---@diagnostic disable-next-line: no-unknown
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
