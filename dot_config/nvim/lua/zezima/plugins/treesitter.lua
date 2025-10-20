vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
  },
})

local treesitter = require("nvim-treesitter")
treesitter.setup({
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local ts_config = require("nvim-treesitter.config")

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    local parsers = require("nvim-treesitter.parsers")
    -- NOTE: we need to roll our own lookml parser, this is half-baked dog poop
    -- but I leave this here to remember how to add custom parsers later
    parsers.lookml = {
      install_info = {
        url = "https://github.com/aclementev/tree-sitter-lookml",
        revision = "7b66b2d0bc502bda45f614cc00a46faa0f690291",
        generate = true,
        generate_from_json = false,
        queries = "queries",
      },
      tier = 2,
      maintainers = { "@aclementev" },
    }
  end,
})

-- Install any missing parsers from ensure_installed
local already_installed = ts_config.get_installed()
local parsers_to_install = vim
  .iter({
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
  })
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()
if #parsers_to_install > 0 then
  treesitter.install(parsers_to_install, { summary = true })
end

local function ts_start(bufnr, parser_name)
  vim.treesitter.start(bufnr, parser_name)
  -- NOTE: Can use regex based syntax-highlighting as fallback as some plugins might need it
  -- vim.bo[bufnr].syntax = "ON"
  -- Use treesitter for folds
  vim.wo.foldlevel = 99
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
  -- Use treesitter for indentation
  vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- On main branch, treesitter isn't started automatically
-- Auto-install and start parsers for any buffer
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable Treesitter",
  callback = function(event)
    local bufnr = event.buf
    local filetype = event.match

    -- Skip if no filetype
    if filetype == "" then
      return
    end

    -- Skip certain filetypes unconditionally
    if
      vim.tbl_contains({
        "snacks_dashboard",
        "snacks_notif",
        "snacks_input",
        "prompt", -- bt: snacks_picker_input
        "csv",
        "tsv",
        "csv_semicolon",
        "csv_whitespace",
        "csv_pipe",
        "rfc_csv",
        "rfc_semicolon",
      }, filetype)
    then
      return
    end

    -- Get parser name based on filetype
    local parser_name = vim.treesitter.language.get_lang(filetype)
    if not parser_name then
      vim.notify(vim.inspect("No treesitter parser found for filetype: " .. filetype), vim.log.levels.WARN)
      return
    end

    -- Try to get existing parser
    if not vim.tbl_contains(ts_config.get_available(), parser_name) then
      return
    end

    -- Check if parser is already installed
    if not vim.tbl_contains(already_installed, parser_name) then
      -- If not installed, install parser asynchronously and start treesitter
      vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
      treesitter.install({ parser_name }):await(function()
        ts_start(bufnr, parser_name)
      end)
      return
    end

    -- Start treesitter for this buffer
    ts_start(bufnr, parser_name)
  end,
})

require("nvim-treesitter-textobjects").setup({
  move = {
    enable = true,
    set_jumps = true,
  },
  swap = {
    enable = true,
  },
})

-- Auto-run :TSUpdate when nvim-treesitter is updated via vim.pack
vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("TreesitterUpdated", { clear = true }),
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.notify("nvim-treesitter was updated, running :TSUpdate", vim.log.levels.INFO)
      vim.schedule(function()
        vim.api.nvim_command("TSUpdate")
      end)
    end
  end,
})
