vim.opt.shell = os.getenv 'SHELL' or 'sh'

vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.isfname:append '@-@'

vim.opt.colorcolumn = '80'
vim.opt.cmdheight = 0
