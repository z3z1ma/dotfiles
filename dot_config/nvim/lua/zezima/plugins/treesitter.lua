vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "master",
  },
})

local treesitter = require("nvim-treesitter.configs")

local csv_formats = {
  csv = true,
  tsv = true,
  csv_semicolon = true,
  csv_whitespace = true,
  csv_pipe = true,
  rfc_csv = true,
  rfc_semicolon = true,
}

---@diagnostic disable-next-line: missing-fields
treesitter.setup({
  auto_install = true, -- NOTE: this implies treesitter CLI installed locally
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if csv_formats[lang] then
        return true
      end
      local max_filesize = 1024 * 1024 * 1 -- 1 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = { enable = true },
  ensure_installed = {
    "bash",
    "c",
    "clojure",
    "commonlisp",
    "cpp",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "fish",
    "gitignore",
    "go",
    "graphql",
    "html",
    "http",
    "java",
    "javascript",
    "jinja",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "printf",
    "python",
    "query",
    "regex",
    "requirements",
    "rust",
    "sql",
    "starlark",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zig",
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
})

-- When in diff mode, we want to use the default
-- vim text objects c & C instead of the treesitter ones.
local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
for name, fn in pairs(move) do
  if name:find("goto") == 1 then
    move[name] = function(q, ...)
      if vim.wo.diff then
        local config = treesitter.get_module("textobjects.move")[name] ---@type table<string,string>
        for key, query in pairs(config or {}) do
          if q == query and key:find("[%]%[][cC]") then
            vim.cmd("normal! " .. key)
            return
          end
        end
      end
      return fn(q, ...)
    end
  end
end

vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("TreesitterUpdated", { clear = true }),
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.notify("nvim-treesitter was updated, running :TSUpdate", vim.log.levels.INFO)
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})
