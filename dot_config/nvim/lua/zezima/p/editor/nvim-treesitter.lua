-- Repo: https://github.com/nvim-treesitter/nvim-treesitter
-- Description: treesitter is a new parser generator tool that we can
-- use in Neovim to power faster and more accurate syntax highlighting.
return {
  "nvim-treesitter/nvim-treesitter",
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "sql", "markdown" },
    },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "css",
      "diff",
      "git_config",
      "git_rebase",
      "go",
      "gomod",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "proto",
      "python",
      "query",
      "regex",
      "rst",
      "rust",
      "sql",
      "terraform",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "scheme",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
  },
}
