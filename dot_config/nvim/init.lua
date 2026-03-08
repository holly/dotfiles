vim.g.mapleader = " "        -- グローバルリーダーキー
vim.g.maplocalleader = " "   -- ローカルリーダーキー

-- 順序が重要なものは明示的に
-- プラグインロードがおわってからconfigを読み込む
require("config")

-- lazy.nvimのブートストラップ（自動インストール）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvimのセットアップ
require("lazy").setup("plugins")

