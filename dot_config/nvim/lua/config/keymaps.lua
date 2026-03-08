local keymap = vim.keymap

-- 検索ハイライトを消す
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
