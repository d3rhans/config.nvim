local status_ok, nf = pcall(require, "nightfox")
if not status_ok then
    return
end

nf.setup({
    options = {
        comments = "italic",
        keywords = "bold",
    }
})

local colorscheme = "terafox"
vim.cmd("colorscheme " .. colorscheme)
