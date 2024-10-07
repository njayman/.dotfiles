local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function date()
	return os.date("%m/%d/%Y")
end

ls.add_snippets("all", {
	s("ATHR", {
		t("/**"),
		t({ "", " * @author " }),
		i(1, "najish.mahmud"),
		t({ "", " * @since " }),
		f(date),
		t({ "", " */" }),
	}),
})
