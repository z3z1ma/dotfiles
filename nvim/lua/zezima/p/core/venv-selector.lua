-- Repo: https://github.com/linux-cultist/venv-selector.nvim
-- Description: Allows selection of python virtual environment from within neovim
return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    name = { ".venv", "venv" },
    auto_refresh = true,
    dap_enabled = true,
  },
  cmd = { "VenvSelect", "VenvSelectCached" },
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
