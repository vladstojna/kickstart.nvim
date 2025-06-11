vim.opt.shell = os.getenv 'SHELL' or 'sh'

vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true

vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.isfname:append '@-@'

vim.opt.colorcolumn = '80'
vim.opt.cmdheight = 0

-- for now, set winborder if nvim is >0.11
-- check if it gets annoying with plugins having double borders
local version = vim.version()
if version.major > 0 or (version.major == 0 and version.minor >= 11) then
  vim.opt.winborder = 'single'
end
