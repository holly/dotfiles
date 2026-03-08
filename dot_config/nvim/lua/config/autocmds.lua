-- vim.cmd('au QuickfixCmdPost vimgrep cw')
-- vim.cmd("au FileType qf nnoremap <silent><buffer>q :quit<CR>")
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "[^l]*",
  command = "cwindow",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
  end,
})
