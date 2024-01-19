local dap = require 'dap'
local dap_vscode = require 'dap.ext.vscode'

dap_vscode.load_launchjs(nil, {
    cppdbg = { 'c', 'cpp', 'rust' },
    lldb = { 'c', 'cpp', 'rust' },
    codelldb = { 'c', 'cpp', 'rust' },
})

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
}

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath 'data' .. '/mason/bin/OpenDebugAD7',
}

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
    },
}
