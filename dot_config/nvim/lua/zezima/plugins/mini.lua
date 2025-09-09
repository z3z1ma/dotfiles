vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.nvim",
    version = "7bbafa4691147bc8b74a51986b957daca14c1876",
  },
  {
    src = "https://github.com/rafamadriz/friendly-snippets",
    version = "main",
  },
})

require("zezima.plugins.snacks") -- Dependency: use the picker for Chezmoi in mini dashboard

local i = {
  [" "] = "Whitespace",
  ['"'] = 'Balanced "',
  ["'"] = "Balanced '",
  ["`"] = "Balanced `",
  ["("] = "Balanced (",
  [")"] = "Balanced ) including white-space",
  [">"] = "Balanced > including white-space",
  ["<lt>"] = "Balanced <",
  ["]"] = "Balanced ] including white-space",
  ["["] = "Balanced [",
  ["}"] = "Balanced } including white-space",
  ["{"] = "Balanced {",
  ["?"] = "User Prompt",
  _ = "Underscore",
  a = "Argument",
  b = "Balanced ), ], }",
  c = "Class",
  f = "Function",
  o = "Block, conditional, loop",
  q = "Quote `, \", '",
  t = "Tag",
}
local a = vim.deepcopy(i)
for k, v in pairs(a) do
  a[k] = v:gsub(" including.*", "")
end
local op_clues = {}
for key, name in pairs(i) do
  table.insert(op_clues, { mode = "o", keys = "i" .. key, desc = "Inside " .. name })
end
for key, name in pairs(a) do
  table.insert(op_clues, { mode = "o", keys = "a" .. key, desc = "Around " .. name })
end

local clue = require("mini.clue")
clue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "<LocalLeader>" },
    { mode = "x", keys = "<LocalLeader>" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },

    -- Operator triggers
    { mode = "o", keys = "a", desc = "around" },
    { mode = "o", keys = "i", desc = "inside" },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
    op_clues,
  },
})

local icons = require("mini.icons")
icons.setup({
  file = {
    -- Chezmoi files
    [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
    ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
    ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
  },
})

local pairs = require("mini.pairs")

Snacks.toggle({
  name = "Mini Pairs",
  get = function()
    return not vim.g.minipairs_disable
  end,
  set = function(state)
    vim.g.minipairs_disable = not state
  end,
}):map("<leader>up")

local pairs_opts = {
  modes = { insert = true, command = true, terminal = false },
  -- Skip autopair when next character is one of these
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  -- Skip autopair when the cursor is inside these treesitter nodes
  skip_ts = { "string" },
  -- Skip autopair when next character is closing pair
  -- and there are more closing pairs than opening pairs
  skip_unbalanced = true,
  -- Deal with markdown code blocks better (copied from LazyVim)
  markdown = true,
}

pairs.setup(pairs_opts)

local pairs_open = pairs.open
---@diagnostic disable-next-line: duplicate-set-field
pairs.open = function(pair, neigh_pattern)
  if vim.fn.getcmdline() ~= "" then
    return pairs_open(pair, neigh_pattern)
  end
  local o, c = pair:sub(1, 1), pair:sub(2, 2)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local next = line:sub(cursor[2] + 1, cursor[2] + 1)
  local before = line:sub(1, cursor[2])
  if pairs_opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
    return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
  end
  if pairs_opts.skip_next and next ~= "" and next:match(pairs_opts.skip_next) then
    return o
  end
  if pairs_opts.skip_ts and #pairs_opts.skip_ts > 0 then
    local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
    for _, capture in ipairs(ok and captures or {}) do
      if vim.tbl_contains(pairs_opts.skip_ts, capture.capture) then
        return o
      end
    end
  end
  if pairs_opts.skip_unbalanced and next == c and c ~= o then
    local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
    local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
    if count_close > count_open then
      return o
    end
  end
  return pairs_open(pair, neigh_pattern)
end

local ai = require("mini.ai")
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
    a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }), -- parameters/arguments
    C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comments
    A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }), -- assignments
    r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }), -- return statements
    l = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }), -- call expressions
    n = ai.gen_spec.treesitter({ a = "@number", i = "@number" }), -- numbers
    s = ai.gen_spec.treesitter({ a = "@string.outer", i = "@string.inner" }), -- strings
    i = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }), -- conditionals
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
    d = { "%f[%d]%d+" }, -- digits
    e = { -- Word with case
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    g = function(ai_type)
      local start_line, end_line = 1, vim.fn.line("$")
      if ai_type == "i" then
        -- Skip first and last blank lines for `i` textobject
        local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
        -- Do nothing for buffer with all blanks
        if first_nonblank == 0 or last_nonblank == 0 then
          return { from = { line = start_line, col = 1 } }
        end
        start_line, end_line = first_nonblank, last_nonblank
      end
      local to_col = math.max(vim.fn.getline(end_line):len(), 1)
      return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
    end,
    u = ai.gen_spec.function_call(), -- u for "Usage"
    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
  },
})

local surround = require("mini.surround")

surround.setup({
  mappings = {
    add = "gsa", -- Add surrounding in Normal and Visual modes
    delete = "gsd", -- Delete surrounding
    find = "gsf", -- Find surrounding (to the right)
    find_left = "gsF", -- Find surrounding (to the left)
    highlight = "gsh", -- Highlight surrounding
    replace = "gsr", -- Replace surrounding
    update_n_lines = "gsn", -- Update `n_lines`
  },
})

local snippets = require("mini.snippets")
local gen_loader = snippets.gen_loader

snippets.setup({
  snippets = {
    gen_loader.from_file("~/.config/nvim/snippets/global.json"),
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

local bracketed = require("mini.bracketed")

bracketed.setup({
  buffer = { suffix = "b", options = {} },
  comment = { suffix = "c", options = {} },
  conflict = { suffix = "x", options = {} },
  diagnostic = { suffix = "d", options = {} },
  file = { suffix = "f", options = {} },
  indent = { suffix = "i", options = {} },
  jump = { suffix = "j", options = {} },
  location = { suffix = "l", options = {} },
  oldfile = { suffix = "o", options = {} },
  quickfix = { suffix = "q", options = {} },
  treesitter = { suffix = "t", options = {} },
  undo = { suffix = "u", options = {} },
  window = { suffix = "w", options = {} },
  yank = { suffix = "y", options = {} },
})

local indentscope = require("mini.indentscope")

indentscope.setup({
  symbol = "│",
  options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "Trouble",
    "alpha",
    "dashboard",
    "fzf",
    "help",
    "lazy",
    "mason",
    "neo-tree",
    "notify",
    "snacks_dashboard",
    "snacks_notif",
    "snacks_terminal",
    "snacks_win",
    "toggleterm",
    "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  callback = function(data)
    vim.b[data.buf].miniindentscope_disable = true
  end,
})

local notify = require("mini.notify")

notify.setup({})
vim.notify = notify.make_notify({
  ERROR = { duration = 5000 },
  WARN = { duration = 4000 },
  INFO = { duration = 3000 },
})

require("mini.statusline").setup({})
require("mini.cursorword").setup({ delay = 1000 })
require("mini.tabline").setup({})
