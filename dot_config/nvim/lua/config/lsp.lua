local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"
local files = vim.fn.glob(lsp_path .. "/*.lua", false, true)
for _, file in ipairs(files) do
  local module = vim.fn.fnamemodify(file, ":t:r")
  require("lsp." .. module)
end

-- 診断表示設定（全LSP共通）
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- LSP用キーバインド
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    -- 定義ジャンプ
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- 型定義ジャンプ
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
    -- 参照検索
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- 実装ジャンプ
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- ホバー情報（すでに動いてる）
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- シグネチャヘルプ
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)  -- 挿入モードでも

    -- リネーム
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- コードアクション
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- 診断ナビゲーション
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
    -- 診断をfloating windowで表示
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

    -- フォーマット
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
