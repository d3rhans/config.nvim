vim.opt.textwidth = 99

local get_python = function()
	local f = assert(io.popen("which python", "r"))
	local p = assert(f:read("*a"))
	f:close()

	return p
end

local dap_python_loaded, dap_python = pcall(require, "dap-python")
if dap_python_loaded then
	dap_python.setup(get_python())

	-- table.insert(require("dap").configurations.python, {
	-- 	env = { ["PYTHONPATH"] = "${workspaceRoot}" },
	-- })
end
