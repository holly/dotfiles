local options = {
  -- for encoding
 encoding = "utf-8",

  --  for backup
  backup = false,
  writebackup = false,
  swapfile = false,
  hidden = false,
  undofile = true, -- undoファイル
  undodir  = os.getenv("HOME") .. "/.vim/undodir",

  -- for perform
 updatetime = 250,
 timeoutlen = 300, -- keymapのタイムアウト時価

  -- for indent
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  numberwidth = 4,
  expandtab = true,
  autoindent = false,
  smartindent = true,

  -- for menu
  wildmenu = true, 
  cmdheight = 1,
  laststatus = 2,
  showcmd = true,

  -- for display
  title = true,
  wrap = true,
  ruler = true,
  number = true,
  relativenumber = false,
  signcolumn = "yes",
  list = true,
  cursorline = true,
  ambiwidth = "double",
  scrolloff = 8,
  sidescrolloff = 8,
  termguicolors = true,

  -- for search
 hlsearch = true,
 incsearch = true,
 ignorecase = true,

  -- for edit setting
 mouse = "a",
 clipboard = "unnamedplus",
 splitright = true, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
 splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる

  -- for complete
 completeopt = "menu,menuone,noselect",  -- 補完メニューの挙動
 pumheight = 10,                         -- 補完メニューの最大表示数


  -- other
 fileencoding = "utf-8",
 fileformats = "unix",
 showmatch = true,
 autochdir = true,
 showtabline = 2,
}

vim.opt.shortmess:append("c")  -- 補完時の不要なメッセージを非表示
vim.opt.iskeyword:append("-")  -- ハイフンを単語の一部として扱う

--t フラグの削除: デフォルトの「テキスト幅（textwidth）に達した時に自動で改行する」機能を無効化します。
-- 効果: 入力中に勝手に改行が入らなくなるため、文章を自分のタイミングで改行したい場合に役立ちます。
vim.opt.formatoptions:remove('t')
-- m フラグの追加: マルチバイト文字（日本語など）の途中で改行を許可します。
-- M フラグの追加: 改行時に、マルチバイト文字の前後にあるスペースを詰めないようにします。
-- 効果: 日本語の文章を整形する際、単語の間に不要な半角スペースが入るのを防ぎ、日本語に適した自然な改行処理が行われるようになります。
vim.opt.formatoptions:append('mM')

--vim.opt.clipboard:append("unnamed")

-- 連想配列の設定を順番に処理
-- VimEnter後に設定を適用（プラグインロード完了後）
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for k, v in pairs(options) do
      vim.opt[k] = v
    end
  end,
})
