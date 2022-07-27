local M = {}

M.in_math = function()
    return (vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1)
end

return M
