local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local template_group = augroup("TemplateAutoInsert", { clear = true })

-- 新規ファイル作成時に拡張子に応じて、雛形ファイルから開くようにする
local templates = {
    { pattern = "*.sh", template = "sh.txt", filetype = "sh" },
    { pattern = "*.py", template = "python.txt", filetype = "python" },
    { pattern = "*.pl", template = "perl.txt", filetype = "perl" },
    { pattern = "*.lua", template = "lua.txt", filetype = "lua" },
    -- 特殊なケース: ファイル名で判定
    { pattern = "Makefile", template = "makefile.txt", filetype = "make" }
}
for _, config in ipairs(templates) do
  autocmd("BufNewFile", {
    group = template_group,
    pattern = config.pattern,
    callback = function()
      local template_path = vim.fn.stdpath("config") .. "/template/" .. config.template

      if vim.fn.filereadable(template_path) == 1 then
        -- テンプレート挿入
        vim.cmd("0read " .. template_path)
        -- 最後の空行削除
        vim.cmd("$delete")
        -- カーソルを先頭に移動
        vim.cmd("normal! gg")

        -- ファイルタイプを明示的に設定
        if config.filetype then
          vim.bo.filetype = config.filetype
        end
      else
        vim.notify("Template not found: " .. template_path, vim.log.levels.WARN)
      end
    end,
    desc = "Insert template for " .. config.pattern,
  })
end
