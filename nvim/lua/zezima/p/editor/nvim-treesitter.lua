local load_textobjects = false

-- Repo: https://github.com/nvim-treesitter/nvim-treesitter
-- Description: treesitter is a new parser generator tool that we can
-- use in Neovim to power faster and more accurate syntax highlighting.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Latest commit
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        init = function()
          -- Disable rtp plugin, as we only need its queries for mini.ai
          -- in case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          load_textobjects = true
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = { enable_autocmd = false },
      },
    },
    cmd = { "TSUpdateSync" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
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
        swap = {
          enable = true,
          swap_next = {
            ["<leader>mp"] = "@parameter.inner",
            ["<leader>mf"] = "@function.outer",
            ["<leader>mc"] = "@class.outer",
          },
          swap_previous = {
            ["<leader>mP"] = "@parameter.inner",
            ["<leader>mF"] = "@function.outer",
            ["<leader>mC"] = "@class.outer",
          },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(
          function(lang)
            if added[lang] then
              return false
            end
            added[lang] = true
            return true
          end,
          ---@diagnostic disable-next-line: param-type-mismatch
          opts.ensure_installed
        )
      end
      require("nvim-treesitter.configs").setup(opts)
      if load_textobjects then
        ---@diagnostic disable-next-line: undefined-field
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            ---@diagnostic disable-next-line: undefined-field
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require("lazy.core.loader")
              Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
              local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
              require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
              break
            end
          end
        end
      end
    end,
  },
  -- Add which-key support for treesitter textobjects
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>m"] = { name = "+move" },
      },
    },
  },
}
