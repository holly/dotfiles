-- Pyright設定
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = vim.fs.root(0, { 
    'pyproject.toml', 
    'setup.py', 
    'setup.cfg', 
    'requirements.txt', 
    'Pipfile', 
    '.git' 
  }),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.enable('pyright')
