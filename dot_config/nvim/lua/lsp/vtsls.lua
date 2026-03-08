-- vtsls（TypeScript/JavaScript LSP）
vim.lsp.config('vtsls', {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = vim.fs.root(0, { 
    'package.json', 
    'tsconfig.json', 
    'jsconfig.json',
    'bun.lockb',
    '.git' 
  }),
})

vim.lsp.enable('vtsls')
