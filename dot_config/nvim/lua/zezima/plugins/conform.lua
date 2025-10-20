vim.pack.add({
  {
    src = "https://github.com/stevearc/conform.nvim",
    version = "fbcb4fa7f34bfea9be702ffff481a8e336ebf6ed",
  },
})

local conform = require("conform")

conform.setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    nix = { "nixfmt" },
    scheme = { "racofmt" },
    python = { "ruff_format", "ruff_organize_imports" },
    lua = { "stylua" },
    fish = { "fish_indent" },
    sh = { "shfmt" },
    ["*"] = { "trim_whitespace" },
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
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
      return
    end
    conform.format({ bufnr = args.buf })
  end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      ["start"] = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.keymap.set("", "<leader>cf", function()
  conform.format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })
