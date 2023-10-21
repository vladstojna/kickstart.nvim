return {
  'rose-pine/neovim',
  priority = 999,
  config = function()
    require('rose-pine').setup {
      variant = 'moon',
      disable_background = true,
    }

    vim.cmd.colorscheme 'rose-pine'
  end,
}
