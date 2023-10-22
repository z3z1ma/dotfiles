return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      }
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }
}
