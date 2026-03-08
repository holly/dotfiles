return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },  -- ファイル開いた時にロード
  config = function()
    require('Comment').setup({
      -- デフォルト設定で十分だが、カスタマイズも可能
    })
  end,
}
