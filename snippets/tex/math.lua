local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local rep = require("luasnip.extras").rep
local postfix = require("luasnip.extras.postfix").postfix
local tools = require("utils.latex.snip_tools")
local modes = require("utils.latex.modes")

local lrmatches = {}
lrmatches["\\left("] = "\\right)"
lrmatches["\\left["] = "\\right]"
lrmatches["\\left\\{"] = "\\right\\}"
lrmatches["\\langle"] = "\\rangle"

local mathSnip = function(head, snip)
    return s(head, snip,
        {
            condition=function(_,_,_) return modes.in_math() end,
            show_condition = function(_) return modes.in_math() end
        }
    )
end

local mathPostfix = function(head, snip)
    return postfix(head, snip,
        {
            condition=function(_,_,_) return modes.in_math() end,
            show_condition = function(_) return modes.in_math() end
        }
    )
end

local mCommandSnip = function(trigger, command)
    return tools.commandSnip(trigger, command,
        {
            condition=function(_,_,_) return modes.in_math() end,
            show_condition = function(_) return modes.in_math() end
        }
    )
end

local mEnvSnip = function(trigger, name)
    return tools.envSnip(trigger, name, t(name), i(0), t(name),
        {
            condition=function(_,_,_) return modes.in_math() end,
            show_condition = function(_) return modes.in_math() end
        }
    )
end

local starEnv = function(trigger, name)
    return tools.envSnip(trigger, name,
        c(1, {t(name), t(name .. "*")}),
        i(0),
        rep(1)
    )
end

local lrPair = function()
    local left = {}
    for key, _ in pairs(lrmatches) do
        table.insert(left, t(key))
    end

    local head = {trig="lr", name="\\left ... \\right"}
    local snip = {
        c(1, left),
        f(function(_, snip) return snip.env.SELECT_RAW end, {}),
        t(" "),
        i(2, " "),
        f(function(args, _) return lrmatches[args[1][1]] end, {1}),
        t(" "),
        i(0)
    }

    return mathSnip(head, snip)
end

local subSupSnip = function(trigger, name)
    head = {trig=trigger, name=name}
    snip = {
        t("\\" .. name .. "_{"),
        i(1),
        t("}^{"),
        i(2),
        t("}"),
        i(0)
    }

    return mathSnip(head, snip)
end

local snippets = {
    mathSnip("par", {t("\\partial")}),
    mathSnip("inf", {t("\\infty")}),
    mathSnip("nab", {t("\\nabla")}),
    mCommandSnip("bb", "\\mathbb{}"),
    mCommandSnip("it", "\\mathit{}"),
    mCommandSnip("cal", "\\mathcal{}"),
    mCommandSnip("bs", "\\boldsymbol{}"),
    mathSnip("frac", {t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0)}),
    mEnvSnip("bmat", "bmatrix"),
    mEnvSnip("pmat", "pmatrix"),
    mEnvSnip("case", "cases"),
    starEnv("align", "align"),
    starEnv("equ", "equation"),
    lrPair(),
    subSupSnip("sum", "sum"),
    subSupSnip("bcup", "bigcup"),
    subSupSnip("prod", "prod"),
}


local autosnippets = {
    mathSnip({trig="_", name="subscript", wordTrig=false},
             {t("_{"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(1), t('}'), i(0)}),
    mathSnip({trig="^", name="supscript", wordTrig=false},
             {t("^{"), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(1), t('}'), i(0)}),
    mathSnip({trig=".c.", hidden=true, wordTrig=false}, {t("\\cdots")}),
    mathSnip({trig=".v.", hidden=true, wordTrig=false}, {t("\\vdots")}),
    mathSnip({trig=".d.", hidden=true, wordTrig=false}, {t("\\ddots")}),
}

return snippets, autosnippets
