vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Home>", "_")
vim.keymap.set("n", "<End>", "$")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
    { desc = "LSP: format buffer" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>su",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[S]earch and replace word [U]nder cursor" })
vim.keymap.set("n", "<leader>px", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<S-h>", vim.cmd.bprevious,
    { silent = true, desc = "Go to previous buffer" })
vim.keymap.set("n", "<S-l>", vim.cmd.bnext,
    { silent = true, desc = "Go to previous buffer" })
