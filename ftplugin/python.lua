km = require("utils.keymaps")

vim.opt.textwidth = 99

local dap_python_loaded, dap_python = pcall(require, "dap-python")
if dap_python_loaded then
    dap_python.setup('~/Code/venvs/debugpy/bin/python')

    local silent_opt = { silent = true }
    km.nnoremap("<leader>dm", dap_python.test_method, silent_opt)
    km.nnoremap("<leader>dc", dap_python.test_class, silent_opt)
    km.vnoremap("<leader>ds", dap_python.debug_selection, silent_opt)

end
