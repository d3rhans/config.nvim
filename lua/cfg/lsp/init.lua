local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "cfg.lsp.setup"
require("cfg.lsp.handlers").setup()
-- require "cfg.lsp.null-ls"
