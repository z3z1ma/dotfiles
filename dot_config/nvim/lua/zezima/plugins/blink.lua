local version = "v1.6.0"
vim.g.blink_cmp_version = version

vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("BlinkUpdated", { clear = true }),
  callback = function(args)
    if vim.g.blink_cmp_version:find("^v") then
      return
    end
    local spec = args.data.spec
    if spec and spec.name == "blink.cmp" and args.data.kind ~= "delete" then
      vim.system({ "cargo", "+nightly", "build", "--release" }, { cwd = args.data.path }, function(rv)
        if rv.code ~= 0 then
          vim.notify(rv.stderr, vim.log.levels.WARN)
        end
      end)
    end
  end,
})

vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = version,
  },
})

local blink = require("blink.cmp")

blink.setup({
  snippets = {
    preset = "mini_snippets",
  },
  signature = { enabled = true },
  keymap = {
    preset = "super-tab",
    ["<Tab>"] = {
      "snippet_forward",
      function()
        return require("sidekick").nes_jump_or_apply()
      end,
      function()
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
  },
  completion = {
    menu = { enabled = true, auto_show = true },
    list = { selection = { preselect = false }, cycle = { from_top = false } },
    ghost_text = {
      enabled = function()
        return not vim.lsp.inline_completion.is_enabled({ bufnr = 0 })
      end,
      show_without_selection = true,
    },
  },
  sources = {
    per_filetype = {
      lua = {
        inherit_defaults = true,
        "lazydev",
      },
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
        async = true,
      },
      lsp = {
        async = true,
        score_offset = 50,
      },
    },
  },
})

vim.keymap.set("n", "<tab>", function()
  return require("sidekick").nes_jump_or_apply() or "<tab>"
end, { expr = true, noremap = true, silent = true })
