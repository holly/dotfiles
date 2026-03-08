return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require('nvim-treesitter.config').setup({
      ensure_installed = { 'lua', 'vim', 'python', 'javascript' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
