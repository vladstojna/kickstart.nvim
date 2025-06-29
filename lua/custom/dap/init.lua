local dap = require 'dap'

dap.adapters = vim.tbl_deep_extend('force', dap.adapters, require 'custom.dap.adapters')

local configs = require 'custom.dap.configurations'
dap.configurations.c = configs
dap.configurations.cpp = configs
dap.configurations.rust = configs
