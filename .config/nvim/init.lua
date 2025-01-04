vim.scriptencoding = "utf-8"

local opt = vim.opt
local api = vim.api
local Plug = vim.fn['plug#']

-- for file
opt.fileencoding = "utf-8"
opt.helplang = "ja", "en"
opt.backup = false
opt.swapfile = false
opt.hidden = false
opt.fileformats = "unix"

-- for indent
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = false
opt.smartindent = true

--for menu
opt.wildmenu = true
opt.cmdheight = 1
opt.laststatus = 2
opt.showcmd = true

-- for display
opt.number = true
opt.wrap = true
opt.title = true
opt.ruler = true
opt.list = true


opt.showmatch = true
opt.autochdir = true
opt.cursorline = true
opt.showtabline = 2
opt.mouse = nil
opt.listchars = { tab =">-", trail ="*", nbsp = "+" }
opt.whichwrap = "b,s,h,l,<,>,[,],~"
opt.backspace = "start,eol,indent"
opt.syntax = "on"
opt.filetype = "plugin", "indent","on"

-- for search
opt.hlsearch = true
opt.incsearch = true

opt.updatetime = 300

opt.ambiwidth = "double"
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:append('mM')

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- vimgrepの結果をquickfixに開くようにする
vim.cmd('au QuickfixCmdPost vimgrep cw')
-- q でquickfixを閉じれるようにする
vim.cmd("au FileType qf nnoremap <silent><buffer>q :quit<CR>")

-- ファイルタイプ別のプラグインやインデント設定を自動適用
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- ripgrepが利用できる場合は、vimgrepをrgで実行するようにする
if vim.fn.executable('rg') == 1 then
    opt.grepprg = 'rg --vimgrep --hidden'
    opt.grepformat = '%f:%l:%c:%m'
end

-- 新規ファイル作成時に拡張子に応じて、雛形ファイルから開くようにする
local templates = {
    { pattern = "*.sh", path = "~/.config/nvim/template/sh.txt" },
    { pattern = "*.py", path = "~/.config/nvim/template/python.txt" },
    { pattern = "*.pl", path = "~/.config/nvim/template/perl.txt" },
    { pattern = "*.zig", path = "~/.config/nvim/template/zig.txt" },
}
for _, template in ipairs(templates) do
    api.nvim_create_autocmd ("BufNewFile", {
        pattern = template.pattern,
        command = "0r" .. " " .. template.path,
    })
end



vim.call("plug#begin")
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug('junegunn/fzf.vim')
Plug('junegunn/vim-easy-align')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('numToStr/Comment.nvim')
Plug('othree/eregex.vim')
Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('Shougo/vimproc.vim', { ["do"] = "make" })
Plug('thinca/vim-quickrun')
Plug('windwp/nvim-autopairs')

-- colorschema
Plug("cocopon/iceberg.vim")
vim.call("plug#end")

-- for colorschema
vim.cmd("colorscheme iceberg")

-- for vim-quickrun
vim.cmd "let g:quickrun_no_default_key_mappings = 1"
-- 常に実行時間を表示する
vim.cmd "let g:quickrun_config = {'*': {'hook/time/enable': '1'}}"
-- 画面右側に結果を表示
vim.cmd "set splitright"
-- 非同期実行
vim.cmd "let g:quickrun_config._ = { 'runner': 'vimproc', 'runner/vimproc/updatetime': 60 }"

-- for Comment.nvim
require('Comment').setup()

-- for indent-blankline
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

-- for nvim-autopairs
require("nvim-autopairs").setup()

-- for fzf
vim.cmd "let $FZF_DEFAULT_OPTS='--layout=reverse'"
vim.cmd "let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob \"!.git/**\"'"
vim.cmd "let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }"

-- for keymap
--<Leader>にスペースを設定
vim.g.mapleader = " "
--<Esc><Esc>でhighlightを消す
api.nvim_set_keymap("n", "<Esc><Esc>", ":nohl<CR>", { noremap = true })
--<leader>r でquickfixを閉じて、保存してからquickrunを実行する
api.nvim_set_keymap("n", "<Leader>r", ":cclose<CR>:write<CR>:QuickRun -mode n<CR>", { noremap = true })
api.nvim_set_keymap("x", "<Leader>r", ":<C-U>cclose<CR>:write<CR>:QuickRun -mode v<CR>", { noremap = true })
--qでquickfixを閉じる
api.nvim_create_autocmd({ "FileType" }, {
    pattern = "qf",
    callback = function()
        api.nvim_set_keymap("n", "<buffer> q", ":cclose<CR>", { noremap = true, silent = true })
    end,
})

-- fzf keybind
api.nvim_set_keymap("n", "<Leader>f", ":Files<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>g", ":GFiles<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>G", ":GFiles?<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>b", ":Buffers<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>h", ":History<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>R", ":Rg<CR>", { noremap = true, silent = true })

-- easy-align keybind
api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { nowait = true })
api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { nowait = true })
