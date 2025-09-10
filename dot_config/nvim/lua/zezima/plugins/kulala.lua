vim.pack.add({
  {
    src = "https://github.com/mistweaverco/kulala.nvim",
    version = "3e81123652a72a2717f9916d6f2b52c2ae6f7e96",
  },
})

require("zezima.plugins.treesitter") -- Dependency: uses treesitter for syntax highlighting

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

local kulala = require("kulala")

kulala.setup({
  global_keymaps = false,
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "",
})

vim.keymap.set("", "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", { desc = "Open scratchpad" })
vim.keymap.set("", "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", { desc = "Copy as cURL" })
vim.keymap.set("", "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", { desc = "Paste from curl" })
vim.keymap.set(
  "",
  "<leader>Rg",
  "<cmd>lua require('kulala').download_graphql_schema()<cr>",
  { desc = "Download GraphQL schema" }
)
vim.keymap.set("", "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", { desc = "Inspect current request" })
vim.keymap.set("", "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", { desc = "Jump to next request" })
vim.keymap.set("", "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", { desc = "Jump to previous request" })
vim.keymap.set("", "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", { desc = "Close window" })
vim.keymap.set("", "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", { desc = "Replay the last request" })
vim.keymap.set("", "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", { desc = "Send the request" })
vim.keymap.set("", "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", { desc = "Show stats" })
vim.keymap.set("", "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", { desc = "Toggle headers/body" })
