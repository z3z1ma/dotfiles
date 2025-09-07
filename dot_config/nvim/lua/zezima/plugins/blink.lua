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
  keymap = {
    preset = "super-tab",
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      -- pmenu is prioritized over inline completion ghost text,
      -- thus it's explicit closure is needed to accept inline completion if both are visible since Tab is overloaded
      -- I like this behavior, for now... I can disable inline completion with C-q if it is out of hand and I cannot use genuine <Tab> in insert mode
      function()
        if not vim.lsp.inline_completion.get() then
          return
        end
      end,
      "fallback",
    },
    ["<C-e>"] = { "hide", "fallback" },
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
