require('lualine').setup {
    options = {
        theme = 'rose-pine',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' ', right = ' ' },
    },
    extensions = {
        'trouble',
        'neo-tree',
        'nvim-dap-ui',
    },
}
