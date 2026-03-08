-- bash-language-server設定
vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  settings = {
    bashIde = {
      -- shellcheckのパス（オプション）
      shellcheckPath = 'shellcheck',
    },
  },
})

vim.lsp.enable('bashls')
