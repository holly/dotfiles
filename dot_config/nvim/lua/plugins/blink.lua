return {
  'saghen/blink.cmp',
  version = '1.*',  -- stableバージョンを使用
  dependencies = 'rafamadriz/friendly-snippets',  -- スニペット集（オプション）
  
  opts = {
    keymap = { preset = 'default' },  -- Ctrl+yで確定など、Vim標準的なキーマップ
    
    appearance = {
      nerd_font_variant = 'mono',
    },
    
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
