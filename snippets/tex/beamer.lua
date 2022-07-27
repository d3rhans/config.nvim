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
local tools = require("utils.latex.snip_tools")

local beamerFrame = function(trigger, options)
    return s({trig=trigger, name="\\frame" .. options .. "{}"},
        fmt([[
            \frame{}{{
                {}{}
            }}
            ]], {
            t(options),
            f(function(_, snip) return snip.env.SELECT_RAW end, {}),
            i(0),
    }))
end

local beamerOverlay = function(trigger, overlay)
    return s({trig=trigger, name="\\" .. overlay .. "<>{}"}, {
        t("\\" .. overlay .. "<"),
        i(1, "spec"), t(">{"),
        f(function(_, snip) return snip.env.SELECT_RAW end, {}),
        i(2), t("}"), i(0)
    })
end

local columnsSnip = function()
    return s({trig="col(%d)", regTrig=true, name="columns"},
        fmt([[
            \begin{{columns}}
                {}
            \end{{columns}}
            ]],
            {
                d(1, function(_, snip)
                    local nodes = {}
                    local ncols = tonumber(snip.captures[1])
                    local scale = math.floor((1/ncols)*100)/100

                    for _=1, ncols do
                        local fm = fmt([[
                        \begin{{column}}{{{}\textwidth}}

                        \end{{column}}

                        ]], {t(tostring(scale))})

                        for _, ff in pairs(fm) do
                            table.insert(nodes, ff)
                        end
                    end

                    return sn(nil, nodes)
                end)
            }
        )
    )
end

local beamerEnvs = {
    {"block", "block", "heading"},
    {"ablock", "alertblock", "heading"},
    {"eblock", "exampleblock", "heading"},
}

local snippets = {
    -- Commands
    beamerFrame("frame", ""),
    beamerFrame("pframe", "[plain]"),
    beamerOverlay("only", "only"),
    beamerOverlay("os", "onslide"),
    beamerOverlay("uc", "uncover"),
    tools.commandSnip("ft", "\\frametitle{}"),
    tools.commandSnip("fst", "\\framesubtitle{}"),
    s({trig="pp", name="\\pause"}, {t("\\pause"), i(0)}),
    columnsSnip(),
}

for _, env in pairs(beamerEnvs) do
    local trigger, name, opt = table.unpack(env)
    table.insert(snippets, tools.doubleEnvSnip(
        trigger, name,
        t(name), i(1, opt), i(0), t(name)
    ))
end

local autosnippets = { }

return snippets, autosnippets
