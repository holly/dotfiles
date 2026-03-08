return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      sh   = { "shfmt" },
      bash = { "shfmt" },
      zsh  = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "4", "-ci" },
      },
    },
  },
}
