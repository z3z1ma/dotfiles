return {
  "oysandvik94/curl.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "CurlOpen", "CurlClose" },
  config = function()
    require("curl").setup({})
  end,
}
