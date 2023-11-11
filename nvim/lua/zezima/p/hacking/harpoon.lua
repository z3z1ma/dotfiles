-- Repo: https://github.com/ThePrimeagen/harpoon
-- Description: The ability to specify, or on the fly, mark and create persisting key strokes to go to the files you want.
return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      { "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon menu" },
      { "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", desc = "Add file as marked" },
      { "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", desc = "Next file" },
      { "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", desc = "Previous file" },
      { "<leader>ht", ":lua require('harpoon.term').gotoTerminal(1)<CR>", desc = "Terminal" },
    },
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },
}
