local has_autocmd = function()
  return #vim.api.nvim_get_autocmds {
    group = 'custom.trouble.jumplist',
    event = { 'BufEnter', 'CursorMoved' },
  } > 0
end

local create_autocmd = function()
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufEnter' }, {
    group = 'custom.trouble.jumplist',
    callback = function()
      local trouble = require 'trouble.api'
      if package.loaded['trouble'] and trouble.is_open { mode = 'loclist' } then
        require('custom.util').replace_loclist_with_jumplist()
        trouble.refresh 'loclist'
      end
    end,
  })
end

local clear_autocmds = function()
  vim.api.nvim_clear_autocmds {
    group = 'custom.trouble.jumplist',
    event = { 'BufEnter', 'CursorMoved' },
  }
  assert(not has_autocmd(), 'Autocmd should have been deleted')
end

return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    use_diagnostic_signs = true,
    auto_preview = true,
    keys = {
      ['J'] = 'next',
      ['K'] = 'prev',
      ['<tab>'] = 'fold_toggle',
    },
    modes = {
      diagnostics = {
        preview = {
          type = 'main',
          wo = {
            winblend = 0,
          },
          border = 'none',
        },
      },
    },
    preview = {
      type = 'float',
      focusable = false,
      size = {
        width = 0.5,
        height = 0.4,
      },
      position = {
        0,
        0.5,
      },
      wo = {
        winblend = 10,
        wrap = true,
      },
    },
    formatters = {
      filename_tail = function(ctx)
        return {
          text = vim.fn.fnamemodify(ctx.item.filename, ':t'),
          hl = 'TroubleFilename',
        }
      end,
      dirname_no_empty = function(ctx)
        local dirname = vim.fn.fnamemodify(ctx.item.filename, ':p:~:.:h')
        return {
          text = dirname == '.' and './' or dirname,
          hl = 'TroubleSource',
        }
      end,
    },
  },
  keys = {
    {
      '<leader>xw',
      function() require('trouble').toggle { mode = 'diagnostics' } end,
      desc = 'Trouble: workspace diagnostics',
    },
    {
      '<leader>xd',
      function() require('trouble').toggle { mode = 'diagnostics', filter = { buf = 0 } } end,
      desc = 'Trouble: buffer diagnostics',
    },
    {
      '<leader>xL',
      function() require('trouble').toggle { mode = 'lsp' } end,
      desc = 'Trouble: LSP',
    },
    {
      '<leader>xl',
      function() require('trouble').toggle { mode = 'loclist', focus = true } end,
      desc = 'Trouble: loclist',
    },
    {
      '<leader>xx',
      function() require('trouble').toggle { mode = 'qflist', focus = true } end,
      desc = 'Trouble: qflist',
    },
    {
      '<leader>xj',
      function()
        if not has_autocmd() then
          create_autocmd()
        elseif require('trouble.api').is_open { mode = 'loclist' } then
          clear_autocmds()
        end

        require('custom.util').replace_loclist_with_jumplist()
        require('trouble').toggle {
          mode = 'loclist',
          sort = {},
          groups = {},
          auto_preview = false,
          auto_refresh = false,
          warn_no_results = false,
          open_no_results = true,
          format = '{file_icon} {filename_tail} {dirname_no_empty}: {text:ts} {pos}',
        }
      end,
      desc = 'Trouble: jumplist',
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_augroup('custom.trouble.jumplist', { clear = true })
    require('trouble').setup(opts)
  end,
}
