local status_ok, nf = pcall(require, "nightfox")
if not status_ok then
    return
end

nf.setup({
    options = {
        transperant = true,
        styles = {
            comments = "italic",
            keywords = "bold",
        },
    },

    groups = {
        terafox = {
            CursorLine = { bg = "bg2" },
        }
    },
})

local colorscheme = "terafox"
vim.cmd("colorscheme " .. colorscheme)
