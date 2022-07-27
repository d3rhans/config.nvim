local km = require("utils.keymaps")
local silent_opt = { silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","



-- Basic binds / more sane settings
km.nnoremap("Y", "y$")
km.nnoremap("<leader>,", ",")
km.nnoremap("n", "nzzzv")
km.nnoremap("N", "Nzzzv")
km.nnoremap("J", "mzJ`z")
km.nnoremap("<leader><Space>", "<cmd>nohlsearch<CR>", silent_opt)

-- Better window navigation
km.nnoremap("<C-h>", "<C-w>h")
km.nnoremap("<C-j>", "<C-w>j")
km.nnoremap("<C-k>", "<C-w>k")
km.nnoremap("<C-l>", "<C-w>l")

-- Resize with arrows
km.nnoremap("<C-Up>", ":resize -2<CR>", silent_opt)
km.nnoremap("<C-Down>", ":resize +2<CR>", silent_opt)
km.nnoremap("<C-Left>", ":vertical resize -2<CR>", silent_opt)
km.nnoremap("<C-Right>", ":vertical resize +2<CR>", silent_opt)

-- Undo breakpoints
km.inoremap(",", ",<c-g>u")
km.inoremap(".", ".<c-g>u")
km.inoremap("!", "!<c-g>u")
km.inoremap("?", "?<c-g>u")
km.inoremap(";", ";<c-g>u")
km.inoremap("<cr>", "<cr><c-g>u")

-- Quickfix last spelling error
km.inoremap("<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u")

-- Keep selection when chaning indent
km.vnoremap("<", "<gv")
km.vnoremap(">", ">gv")

-- Move selected text up and down
km.vnoremap("<A-j>", ":m .+1<CR>==", silent_opt)
km.vnoremap("<A-k>", ":m .-2<CR>==", silent_opt)
km.xnoremap("<A-j>", ":move '>+1<CR>gv-gv", silent_opt)
km.xnoremap("<A-k>", ":move '<-2<CR>gv-gv", silent_opt)


-- Telescope
km.nnoremap("<leader>f", "<cmd>Telescope find_files<cr>", silent_opt)
km.nnoremap("<leader>b", "<cmd>Telescope buffers<cr>", silent_opt)
km.nnoremap("<leader>h", "<cmd>Telescope help_tags<cr>", silent_opt)
km.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>", silent_opt)
km.nnoremap("<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", silent_opt)
km.nnoremap("<leader>w", "<cmd>Telescope lsp_workspace_symbols<cr>", silent_opt)
km.nnoremap("<leader>r", "<cmd>Telescope lsp_references<cr>", silent_opt)

-- Bye
km.nnoremap("<leader>Q", "<cmd>Bdelete<cr>", silent_opt)

-- Neogen
km.nnoremap("<leader>D", "<cmd>Neogen<cr>", silent_opt)

-- Luasnip
local snip_status_ok, ls = pcall(require, "luasnip")
if snip_status_ok then
    local expand_jump_or_tab = function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        else
            local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
            vim.api.nvim_feedkeys(tab, "n", false)
        end
    end

    local next_choice = function()
        if ls.choice_active() then
            ls.change_choice(1)
        else
            local ce = vim.api.nvim_replace_termcodes("<C-E>", true, false, true)
            vim.api.nvim.nvim_feedkeys(ce, "n", false)
        end
    end

    km.inoremap("<Tab>", expand_jump_or_tab)
    km.inoremap("<S-Tab>", function() ls.jump(-1) end)
    km.snoremap("<Tab>", function() ls.jump(1) end)
    km.snoremap("<S-Tab>", function() ls.jump(-1) end)
    km.inoremap("<C-E>", next_choice)
    km.snoremap("<C-E>", next_choice)
end
