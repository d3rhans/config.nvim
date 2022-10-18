-- local status_ok, nf = pcall(require, "nightfox")
-- if not status_ok then
--     return
-- end
--
-- nf.setup({
--     options = {
--         transparent = true,
--         terminal_colors = true,
--         styles = {
--             comments = "italic",
--             keywords = "bold",
--         },
--     },
--
--     groups = {
--         terafox = {
--             CursorLine = { bg = "bg2" },
--         }
--     },
-- })

local colorscheme = "habamax"
vim.cmd("colorscheme " .. colorscheme)
