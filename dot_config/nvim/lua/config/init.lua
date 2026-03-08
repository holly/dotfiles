local config_path = vim.fn.stdpath("config") .. "/lua/config"

-- 優先読み込み
local modules = {
  "options",
  "keymaps"
}
for _, module in ipairs(modules) do
  file = config_path .. "/" .. module .. ".lua"
  if vim.fn.filereadable(file) == 1 then
    require("config." .. vim.fn.fnamemodify(file, ":t:r"))
  end
end


-- config配下のすべての.luaファイルを取得
local files = vim.fn.glob(config_path .. "/*.lua", false, true)

for _, file in ipairs(files) do
  local module = vim.fn.fnamemodify(file, ":t:r")
  -- すでに読み込んだものとinit.luaは除外
  if module ~= "init" and module ~= "options" and module ~= "keymaps" then
    require("config." .. module)
  end
end
