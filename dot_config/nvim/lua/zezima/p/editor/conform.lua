return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      nix = { "nixfmt" },
      scheme = { "racofmt" },
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
}
