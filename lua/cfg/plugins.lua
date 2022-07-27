-- Comment
local comment_loaded, comment = pcall(require, "Comment")
if comment_loaded then
    comment.setup()
end

-- Neogen
local neogen_loaded, neogen = pcall(require, "neogen")
if neogen_loaded then
    neogen.setup({
        enable = true,
        snippet_engine = 'luasnip',
        languages = {
            python = {
                template = {
                    annotation_convention = "numpydoc"
                }
            }
        }
    })
end

-- Vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0
