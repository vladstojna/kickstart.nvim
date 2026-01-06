-- Custom lsp setup for specific language servers that
-- I don't want to use with Mason

local M = {}

M.configure = function()
  local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities())

  vim.lsp.config('clangd', {
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    capabilities = capabilities,
    settings = {},
  })
  vim.lsp.enable 'clangd'

  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
        },
      },
    },
  })
  vim.lsp.enable 'rust_analyzer'
end

return M
