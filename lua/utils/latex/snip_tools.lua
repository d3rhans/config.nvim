local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}

local envString = [[
    \begin{{{}}}
        {}{}
    \end{{{}}}
]]

local doubleEnvString = [[
    \begin{{{}}}{{{}}}
        {}{}
    \end{{{}}}
]]

M.envSnip = function(trigger, name, begNode, stopNode, endNode, options)
    options = options or {}

    return s({trig=trigger, name=name},
        fmt(envString, {
            begNode,
            f(function(_, snip) return snip.env.SELECT_RAW end, {}),
            stopNode,
            endNode
        }), options
    )
end

M.doubleEnvSnip = function(trigger, name, begNode, optNode, stopNode, endNode)
    return s({trig=trigger, name=name},
        fmt(doubleEnvString, {
            begNode,
            optNode,
            f(function(_, snip) return snip.env.SELECT_RAW end, {}),
            stopNode,
            endNode
        })
    )
end

M.commandSnip = function(trigger, command, options)
    options = options or {}

    return s({trig=trigger, name=command}, {
            t(string.sub(command, 1, -2)), f(function(_, snip) return snip.env.SELECT_RAW end, {}), i(1), t("}"), i(0)
        }, options)
end

return M
