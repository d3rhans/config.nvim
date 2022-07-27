local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "", "Comment" } },
			},
		},
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})


require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
