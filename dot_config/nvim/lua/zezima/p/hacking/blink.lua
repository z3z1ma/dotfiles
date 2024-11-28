return {
  "saghen/blink.cmp",
  version = "0.5.1",
  dependencies = { "kristijanhusak/vim-dadbod-completion" },
  opts = {
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
  },
}
