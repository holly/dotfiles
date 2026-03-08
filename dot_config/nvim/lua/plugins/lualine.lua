return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- アイコン表示用（オプション）
  config = function()
    require('lualine').setup({
      -- 最もシンプルな設定
      options = {
        theme = 'auto',  -- カラースキームに自動追従
      }
    })
  end
}
