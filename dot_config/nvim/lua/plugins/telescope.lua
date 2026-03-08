return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',  -- 必須依存
  },
  keys = {
   -- { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
   -- { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
   -- { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
   -- { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
      {
        "ff",
        function()
            require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files"
      },
      {
        "fg",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = "Live grep"
      },
      {
        "fb",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "Buffers"
      },
      {
        "fo",
        function()
            require("telescope.builtin").oldfiles()
        end,
        desc = "Find old files"
      },
      {
        "fh",
        function()
            require("telescope.builtin").help_tags()
        end,
        desc = "Help"
      },
  },
  config = function()
    require('telescope').setup({
    })
  end,
}
