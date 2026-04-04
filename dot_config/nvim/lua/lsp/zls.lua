vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_dir = vim.fs.root(0, {
        'build.zig',
        'build.zig.zon',
        '.git',
    }),
    settings = {
        zls = {
            -- 関数の引数プレースホルダーを自動挿入する設定（おすすめ）
            enable_argument_placeholders = true,
            -- `if`, `for` などのスニペットを自動生成する設定（おすすめ）
            enable_autogen_snippets = true,
        },
    },
})

vim.lsp.enable('zls')
