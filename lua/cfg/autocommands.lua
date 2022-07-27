local setup_group = vim.api.nvim_create_augroup("SetupAUGroup", { clear = true})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown", "tex", "text" },
    group = setup_group,
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = setup_group,
    callback = function()
        vim.cmd [[:%s/\s\+$//e]]
        vim.cmd [[:%s/\($\n\s*\)\+\%$//e]]
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "packer.lua" },
    group = setup_group,
    callback = function()
        file = vim.fn.expand("<afile>")
        source_cmd = ":so " ..  file
        vim.cmd(source_cmd)
        vim.cmd [[:PackerSync]]
    end,
})
