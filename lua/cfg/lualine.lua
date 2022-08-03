local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- local hide_in_width = function()
--     return vim.fn.winwidth(0) > 80
-- end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic", "nvim_lsp" },
    sections = { "error", "warn", "info"},
    symbols = { error = " ", warn = " ", info=" "},
    colored = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local filetype = {
    "filetype",
    icon_only = true,
}

local location = {
    "location",
    padding = 1,
}

local tabs = {
    "tabs",
    mode = 2,

    tabs_color = {
        active = 'lualine_a_normal',
        inactive = 'lualine_b_normal',
    },

    cond = function()  return #vim.api.nvim_list_tabpages() > 1 end,
}

local function navic_loc()
    local navic_ok, navic = pcall(require, "nvim-navic")
    if navic_ok then
        if navic.is_available() then
            local loc = navic.get_location()

            if loc ~= nil and loc ~= '' then
                return ">  " .. navic.get_location()
            end
        end
    end
    return ''
end


lualine.setup {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard" },
        always_divide_middle = true,
    },
    tabline = {
        lualine_b = {  filetype, "filename", navic_loc },
        lualine_z = { tabs }
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {"branch"},
        lualine_c = { diagnostics },
        lualine_x = { diff },
        lualine_y = { location },
        lualine_z = { "progress" },
    },
}
