local M = {
  -- cmdline tools
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "ruff",
        "sqlfmt",
        "yamllint",
        "yamlfmt",
        "jq",
        "stylua",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local registry = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local package = registry.get_package(tool)
          if not package:is_installed() then
            package:install()
          end
        end
      end
      if registry.refresh then
        registry.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}

return M
