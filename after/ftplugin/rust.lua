-- Disable mini.pairs for single-quotes because of lifetime syntax
-- https://www.reddit.com/r/neovim/comments/171xezk/comment/k3thqbf/
vim.keymap.set('i', "'", "'", { buffer = 0 })
