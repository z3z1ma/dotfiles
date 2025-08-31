return {
  -- Repo: https://github.com/stevearc/conform.nvim
  -- Description: Lightweight yet powerful formatter plugin for Neovim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        scheme = { "racofmt" },
        python = { "ruff_format", "ruff_organize_imports" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        sqlfmt = {
          command = "sqlfmt",
          args = { "-q", "-" },
        },
        racofmt = {
          command = "raco",
          args = { "fmt", "--width", 50 },
        },
      },
    },
  },

  -- Repo: https://github.com/Bekaboo/dropbar.nvim
  -- Description: IDE-like breadcrumbs, out of the box
  {
    "Bekaboo/dropbar.nvim",
  },
}
