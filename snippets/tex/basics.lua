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
local tools = require("utils.latex.snip_tools")

local docSetup = function()
    return s({trig="doc", name="document"},
        fmt([[
            \documentclass{{{}}}

            \begin{{document}}
                {}{}
            \end{{document}}
        ]], {
            i(1, "class"),
            f(function(_, snip) return snip.env.SELECT_RAW end, {}),
            i(0)
    }))
end


local tableEnv = function()
    return s({trig="table", name="table"},
        fmt([[
            \begin{{table}}[{}]
                \centering
                {}{}
            \end{{table}}
            ]], {
            i(1, "h"),
            f(function(_, snip) return snip.env.SELECT_RAW end, {}),
            i(0),
    }))
end

local figureEnv = function()
    return s({trig="fig", name="figure"},
        fmt([[
            \begin{{figure}}[{}]
                \centering
                \includegraphics[{}]{{{}}}{}
            \end{{figure}}
            ]], {
            i(1, "h"),
            i(2, "scale"),
            i(3, "file"),
            i(0),
    }))
end

local arrayLine = function()
    return s({trig="&(%d+)", regTrig=true},
        d(1, function(_, snip)
            local jumps = tonumber(snip.captures[1])
            local nodes = {}

            for j=1, jumps do
                table.insert(nodes, i(j))
                table.insert(nodes, t(" & "))
            end
            table.insert(nodes, i(0))

            return sn(nil, nodes)

        end, {}
        )
    )
end


-- Snippets
local snippets = {
    docSetup(),
    s({trig="root"}, { t("% !TEX root = "), i(1, "main.tex"), i(0)}),
    s({trig="\\", hidden=true}, {
        t("\\"), i(1, "command"), t("{"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(2), t("}"), i(0)
    }),
    s({trig="-", hidden=true}, {t("\\item ")}),
    tools.envSnip("beg", "\\begin{}...\\end{}", i(1, "env"), i(0), rep(1)),

    tableEnv(),
    figureEnv(),
    arrayLine(),
}

local commands = {
    {"tbf", "\\textbf{}"},
    {"tit", "\\textit{}"},
    {"sec", "\\section{}"},
    {"ssec", "\\subsection{}"},
    {"sssec", "\\subsubsection{}"},
    {"cap", "\\caption{}"},
    {"lab", "\\label{}"},
    {"cite", "\\cite{}"},
}

local simpleEnvs = {
    {"item", "itemize"},
    {"enum", "enumerate"},
    {"center", "center"},
}

local doubleEnvs = {
    {"tabular", "tabular", "cells"},
    {"subf", "subfigure", "size"},
}

for _, command in pairs(commands) do
    table.insert(snippets, tools.commandSnip(command[1], command[2]))
end

for _, senv in pairs(simpleEnvs) do
    local trigger, name = senv[1], senv[2]
    table.insert(snippets, tools.envSnip(trigger, name, t(name), i(0), t(name)))
end

for _, denv in pairs(doubleEnvs) do
    local trigger, name, opt = denv[1], denv[2], denv[3]
    table.insert(snippets, tools.doubleEnvSnip(trigger, name, t(name), i(1, opt), i(0), t(name)))
end

-- Autosnippets
local autosnippets = {
    s({trig="...", hidden=true, wordTrig=false}, {
        t("\\ldots")
    }),
}

return snippets, autosnippets
