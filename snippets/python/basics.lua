local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep


local snippets = {
    s({trig=".", hidden=true}, {t("self.")}),
    s({trig="doc", name="docstring"},
        {t("\"\"\""), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(0), t("\"\"\"")}),

    s({trig="main"}, fmt([[
        if __name__ == "__main__":
            {}{}
    ]], {f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(0)})),

    s({trig="open"}, fmt([[
        with open({}) as {}:
            {}{}
    ]], {i(1, "file"), i(2, "fobj"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(0)})),

    s({trig="init"}, fmt([[
        def __init__(self, {}):
            {}{}
    ]], {i(1, "args"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(0)})),


    s({trig="def"}, fmt([[
        def {}({}):
            {}{}
    ]], {i(1, "func"), i(2, "args"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(0)})),
}

local autosnippets = {}


return snippets, autosnippets
