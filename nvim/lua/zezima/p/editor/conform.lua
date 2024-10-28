return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      go = { "gofmt", "goimports" },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      rust = { "rustfmt" },
      nix = { "nixfmt" },
      scheme = { "racofmt" },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      sqlfmt = {
        command = "sqlfmt",
        args = { "-q", "-" },
      },
      racofmt = {
        command = "raco",
        args = { "fmt", "--width", 50 },
      },
    },
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
  },
  init = function()
    -- Install the conform formatter on VeryLazy
    LazyVim.on_very_lazy(function()
      LazyVim.format.register({
        name = "conform.nvim",
        priority = 100,
        primary = true,
        format = function(buf)
          require("conform").format({ bufnr = buf })
        end,
        sources = function(buf)
          local ret = require("conform").list_formatters(buf)
          ---@param v conform.FormatterInfo
          return vim.tbl_map(function(v)
            return v.name
          end, ret)
        end,
      })
    end)
  end,
}
