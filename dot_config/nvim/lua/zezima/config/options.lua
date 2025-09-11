-- Core handles
local g = vim.g
local opt = vim.opt

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
opt.timeout = true -- Enable timeout for mapped sequences
opt.timeoutlen = 1000 -- Initial map timeout
opt.ttimeoutlen = 10 -- Key code timeout
opt.updatetime = 200 -- Save swap/trigger CursorHold
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Final timeout override (keep last to preserve intent)
opt.timeoutlen = vim.g.vscode and 1000 or 300

-- UI & appearance
opt.termguicolors = true -- True color support
opt.cursorline = true -- Highlight current line
opt.number = true -- Absolute line numbers
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes" -- Prevent text shift
opt.ruler = false -- Disable default ruler
opt.title = true -- Window title
opt.titlestring = "%<%F%=%l/%L - nvim" -- Title format
opt.pumblend = 10 -- Popup transparency
opt.pumheight = 10 -- Popup max entries
opt.list = true -- Show some invisible chars
opt.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ " }
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
opt.smoothscroll = true -- Smooth scrolling
opt.cmdheight = 0 -- Hide command line unless needed
opt.winminwidth = 5 -- Minimum window width

-- Highlight settings
vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })

-- Windows, splits & statusline
opt.laststatus = 3 -- Global statusline
opt.splitbelow = true -- New windows below
opt.splitright = true -- New windows to the right
opt.splitkeep = "screen" -- Keep layout on open

-- Movement & view
opt.jumpoptions = "view" -- Better jump behavior
opt.scrolloff = 8 -- Keep 8 lines of context
opt.sidescrolloff = 25 -- Keep 25 columns of context
opt.wrap = false -- No line wrap
opt.virtualedit = "block" -- Visual block free-cursor

-- Search & substitution
opt.grepformat = "%f:%l:%c:%m" -- Filename:line:col:msg
opt.grepprg = "rg --vimgrep --smart-case --hidden --follow"
opt.ignorecase = false -- Ignore case
opt.smartcase = true -- Smart case when capitals used
opt.inccommand = "nosplit" -- Live substitute preview
opt.wildmode = "longest:full,full" -- Cmdline completion

-- Completion
opt.completeopt = "menu,menuone,fuzzy,noselect,preview"

-- Editing behavior
opt.confirm = true -- Confirm before exit
opt.backspace = "indent,eol,start" -- Backspace like other editors
opt.expandtab = true -- Spaces instead of tabs
opt.shiftwidth = 2 -- Indent size
opt.shiftround = true -- Round indent
opt.smarttab = true -- Smarter tabs
opt.smartindent = true -- Auto indent
opt.formatexpr = "v:lua.require'conform'.formatexpr()" -- Use conform

-- Formatting preferences
opt.conceallevel = 0 -- Don't hide markup
opt.linebreak = true -- Wrap at convenient points
opt.showmode = false -- Statusline shows mode
opt.formatoptions = "l"
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- Respect textwidth in comments
  - "o" -- O/o don't continue comments
  + "r" -- Continue comments on <CR>
  + "n" -- Indent past formatlistpat
  + "j" -- Auto-remove comments when possible
  - "2" -- Not in gradeschool anymore

-- Spelling
opt.spell = false
opt.spelllang = { "en" }

-- Sessions & persistence
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.swapfile = false -- No swap
opt.backup = false -- No backup
opt.undodir = vim.fn.stdpath("data") .. "/.undo" -- Undo dir
opt.undofile = true -- Persistent undo
opt.undolevels = 10000 -- Undo depth

-- Folding (Treesitter-driven)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = "v:lua.require'zezima.utils'.foldtext()"

-- Clipboard (defer for SSH/OSC52)
vim.schedule(function()
  -- Only set clipboard if not in SSH, to keep OSC 52 working automatically
  opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

opt.lazyredraw = true -- Faster scrolling

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
