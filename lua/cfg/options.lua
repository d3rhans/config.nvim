local options = {
    fileencoding = "utf-8",     -- Unicode
    clipboard = "",             -- No system clipboard stuff
    guicursor = "",             -- Block cursor
    showmatch = true,           -- Show matching {[()]}
    cursorline = true,          -- Highlight current line
    textwidth = 100,            -- Standard line width
    scrolloff = 10,             -- 10 lines before and after while scrolling
    number = true,              -- Line numbers
    relativenumber = true,      -- relative numbers
    laststatus = 2,             -- Always show statusline in last window
    cmdheight = 2,              -- More space
    hidden = true,              -- Allow switching away from unsaved buffers
    errorbells = false,         -- Silence,
    modeline = false,           -- Not executing stuff
    ruler = true,               -- Show ruler
    signcolumn = "yes",         -- Always show sign column
    background = "dark",        -- Dark :)
    splitright = true,          -- split vertically to the right
    splitbelow = true,          -- split horizontally to the bottom

    -- undo/history/swap
    swapfile = false,           -- I hate these
    backup = false,             -- I don't need these
    undofile = true,            -- I love these
    writebackup = false,        -- No...

    -- tabs, indents, spaces
    tabstop = 4,                -- insert 4 spaces for a tab
    shiftwidth = 4,             -- the number of spaces inserted for each indentation
    softtabstop = 4,            -- Number of spaces for a tab while editing
    smartindent = true,         -- make indenting smarter again
    expandtab = true,           -- convert tabs to spaces
    autoindent = true,          -- Take over indent from last

    completeopt = {"menuone", "noinsert", "noselect"},
    wildignore = {
        "__pycache__",
        "*.pyc",
        "*.o",
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.fdb_latexmk",
        "*.fls",
        "*.pdf",
        "*.synctex.gz",
        "*.png",
        "*.jpg",
        "*.eps",
        "*.run.xml"
    },

    -- Spell checking
    spelllang = { "de_de", "en_us" },
    spell = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.path:append("**")
vim.opt.diffopt:append("vertical")
vim.opt.shortmess:append("c")

-- Vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0
