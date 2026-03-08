-- Lua Language Server設定（Neovim用に最適化）
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_dir = vim.fs.root(0, { '.git', '.luarc.json', '.luarc.jsonc' }),
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',  -- NeovimはLuaJITを使用
      },
      diagnostics = {
        globals = { 'vim' },  -- vimをグローバル変数として認識
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,  -- Neovim APIを認識
        },
        checkThirdParty = false,  -- 外部ライブラリ確認を無効化
      },
      telemetry = {
        enable = false,  -- テレメトリ無効化
      },
    },
  },
})

vim.lsp.enable('lua_ls')
