return {
  "kndndrj/nvim-dbee",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup(--[[optional config]])
  end,
  keys = {
    {
      "<leader>D",
      function()
        require("dbee").toggle()
      end,
      desc = "Toggle dbee",
    },
  },
}
