local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local km = require("utils.keymaps")
local silent_opt = { silent = true }

-- Keybinds
km.nnoremap("<F2>", dap.toggle_breakpoint, silent_opt)
km.nnoremap("<F3>", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, silent_opt)
km.nnoremap("<F4>", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
end, silent_opt)

km.nnoremap("<F5>", dap.continue, silent_opt)
km.nnoremap("<F6>", dap.step_over, silent_opt)
km.nnoremap("<F7>", dap.step_into, silent_opt)
km.nnoremap("<F8>", dap.step_out, silent_opt)
km.nnoremap("<F9>", dap.repl.open, silent_opt)
km.nnoremap("<F10>", dap.run_last, silent_opt)

-- Signs
local sd = vim.fn.sign_define
sd('DapBreakpoint', {text='ﴫ', texthl='', linehl='', numhl=''})
sd('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
sd('DapLogPoint', {text='', texthl='', linehl='', numhl=''})
sd('DapStopped', {text='', texthl='', linehl='', numhl=''})
sd('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})

local dapui_loaded, dapui = pcall(require, "dapui")
if dapui_loaded then
    print("Dap UI loaded")
    dapui.setup()
end

local dap_vt_loaded, dap_vt = pcall(require, "nvim-dap-virtual-text")
if dap_vt_loaded then
    dap_vt.setup()
end
