local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

local lspconfig = require("lspconfig")

local servers = {
    "texlab",
    "pyright",
    "sumneko_lua",
    "clangd",
    "rust_analyzer",
    "taplo"
}

mason_lspconfig.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("cfg.lsp.handlers").on_attach,
        capabilities = require("cfg.lsp.handlers").capabilities,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "cfg.lsp.settings." .. server)

    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    if server == "rust_analyzer" then
        require("rust-tools").setup({
            server = {
                on_attach = require("cfg.lsp.handlers").on_attach,
                capabilities = require("cfg.lsp.handlers").capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
        })

        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
