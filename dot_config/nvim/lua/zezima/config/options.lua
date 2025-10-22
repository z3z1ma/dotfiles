-- Core handles
local g, o = vim.g, vim.opt

-- Leaders (also set in init.lua) & global toggles
g.mapleader = " "
g.maplocalleader = "\\"

g.autoformat = true -- Auto formatting
g.root_spec = { "lsp", { ".git", "lua" }, "cwd" } -- Root dir detection
g.root_lsp_ignore = { "copilot" }

g.ai_cmp = true -- Completion engine
g.snacks_animate = false -- Snacks animations
g.deprecation_warnings = false -- Deprecation warnings
g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- Timing & interaction
o.timeout = true -- Enable timeout for mapped sequences
o.timeoutlen = 1000 -- Initial map timeout
o.ttimeoutlen = 10 -- Key code timeout
o.updatetime = 200 -- Save swap/trigger CursorHold
o.shortmess:append({ W = true, I = true, c = true, C = true })

-- Final timeout override (keep last to preserve intent)
o.timeoutlen = vim.g.vscode and 1000 or 300

-- UI & appearance
o.termguicolors = true -- True color support
-- o.cursorline = true -- Highlight current line
o.number = true -- Absolute line numbers
o.relativenumber = true -- Relative line numbers
o.signcolumn = "yes:1" -- Prevent text shift
o.ruler = false -- Disable default ruler
o.title = true -- Window title
o.titlestring = "%<%F%=%l/%L - nvim" -- Title format
o.pumblend = 10 -- Popup transparency
o.pumheight = 10 -- Popup max entries
o.list = true -- Show some invisible chars
-- o.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ " }
o.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
o.smoothscroll = true -- Smooth scrolling
o.cmdheight = 0 -- Hide command line unless needed
o.winminwidth = 5 -- Minimum window width
o.synmaxcol = 1000 -- Max column for syntax highlight
o.redrawtime = 10000 -- avoid “match” timeouts
o.updatetime = 200 -- throttle CursorHold (diagnostics/updates)

-- Highlight settings
vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })

-- Windows, splits & statusline
o.laststatus = 3 -- Global statusline
o.splitbelow = true -- New windows below
o.splitright = true -- New windows to the right
o.splitkeep = "screen" -- Keep layout on open

-- Movement & view
o.jumpoptions = "view" -- Better jump behavior
o.scrolloff = 8 -- Keep 8 lines of context
o.sidescrolloff = 25 -- Keep 25 columns of context
o.wrap = false -- No line wrap
o.virtualedit = "block" -- Visual block free-cursor

-- Search & substitution
o.grepformat = "%f:%l:%c:%m" -- Filename:line:col:msg
o.grepprg = "rg --vimgrep --smart-case --hidden --follow"
o.ignorecase = false -- Ignore case
o.smartcase = true -- Smart case when capitals used
o.inccommand = "nosplit" -- Live substitute preview
o.wildmode = "longest:full,full" -- Cmdline completion

-- Completion
o.completeopt = "menu,menuone,fuzzy,noselect,preview"

-- Editing behavior
o.confirm = true -- Confirm before exit
o.backspace = "indent,eol,start" -- Backspace like other editors
o.expandtab = true -- Spaces instead of tabs
o.shiftwidth = 2 -- Indent size
o.shiftround = true -- Round indent
o.smarttab = true -- Smarter tabs
o.smartindent = true -- Auto indent
o.formatexpr = "v:lua.require'conform'.formatexpr()" -- Use conform

-- Formatting preferences
o.conceallevel = 0 -- Don't hide markup
o.linebreak = true -- Wrap at convenient points
o.showmode = false -- Statusline shows mode
o.formatoptions = "l"
o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- Respect textwidth in comments
  - "o" -- O/o don't continue comments
  + "r" -- Continue comments on <CR>
  + "n" -- Indent past formatlistpat
  + "j" -- Auto-remove comments when possible
  - "2" -- Not in gradeschool anymore

-- Spelling
o.spell = false
o.spelllang = { "en" }

-- Sessions & persistence
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
o.swapfile = false -- No swap
o.backup = false -- No backup
o.undodir = vim.fn.stdpath("data") .. "/.undo" -- Undo dir
o.undofile = true -- Persistent undo
o.undolevels = 10000 -- Undo depth

-- Folding (Treesitter-driven)
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldtext = "v:lua.require'zezima.utils'.foldtext()"

-- Clipboard (defer for SSH/OSC52)
vim.schedule(function()
  -- Only set clipboard if not in SSH, to keep OSC 52 working automatically
  o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

o.lazyredraw = true -- Faster scrolling

-- Neovide (GUI) settings
g.neovide_opacity = 0.4
g.neovide_normal_opacity = 0.4
g.transparency = 0.8

-- Helper for background alpha
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end

g.neovide_background_color = "#0f1117" .. alpha()
g.neovide_window_blurred = true
g.neovide_macos_simple_fullscreen = true
g.neovide_input_macos_option_key_is_meta = "only_left"

if g.neovide then
  local change_transparency = function(delta)
    g.neovide_opacity = g.neovide_opacity + delta
    g.neovide_background_color = "#0f1117" .. alpha()
  end
  vim.keymap.set({ "n", "v", "o" }, "<D-]>", function()
    change_transparency(0.01)
  end)
  vim.keymap.set({ "n", "v", "o" }, "<D-[>", function()
    change_transparency(-0.01)
  end)
end
