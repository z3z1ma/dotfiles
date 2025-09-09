-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Auto formatting
vim.g.autoformat = true

-- Root dir detection
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.root_lsp_ignore = { "copilot" }

-- Python LSP
vim.g.zezima_python_lsp = "ty"

-- Completion engine settings
vim.g.zezima_blink_main = false
vim.g.zezima_cmp = "auto"
vim.g.ai_cmp = true

-- Picker settings
vim.g.zezima_picker = "auto"

-- Snacks animations

vim.g.snacks_animate = true
-- Deprecation warnings
vim.g.deprecation_warnings = false

-- Trouble lualine integration
vim.g.trouble_lualine = true

local opt = vim.opt

opt.timeout = true -- Enable timeout for mapped sequences
opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete

opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.autowrite = true -- Enable auto write
-- Only set clipboard if not in ssh, to make sure the OSC 52 integration works automatically
vim.schedule(function()
  opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)
opt.completeopt = "menu,menuone,fuzzy,noselect,preview" -- Completion options
opt.conceallevel = 0 -- Keep zezima preference: don't hide markup
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m" -- Filename:line:column:message
opt.grepprg = "rg --vimgrep --smart-case --hidden --follow" -- Use ripgrep for search with zezima's preferred flags
opt.ignorecase = false -- Keep zezima preference: don't ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view" -- Better jump behavior
opt.laststatus = 3 -- Global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ " } -- Set some invisible characters
opt.mouse = "a" -- Enable mouse mode
opt.title = true -- Set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- What the title of the window will be set to
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.scrolloff = 8 -- Keep zezima preference: 8 lines of context
opt.sidescrolloff = 25 -- Keep zezima preference: 25 columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spell = false -- Disable spell checking by default
opt.spelllang = { "en" } -- Spell check
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen" -- Keep window layout when opening a new file
opt.splitright = true -- Put new windows right of current
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Time to wait for a mapped sequence to complete
opt.swapfile = false -- No swap file
opt.backup = false -- No backup file
opt.undodir = vim.fn.stdpath("data") .. "/.undo" -- Undo directory
opt.undofile = true -- Save undo history, so that it can persist across sessions
opt.undolevels = 10000 -- Maximum number of changes that can be undone
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.splitkeep = "screen" -- Keep window layout when opening a new file
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
opt.foldmethod = "expr" -- Set foldmethod to expr
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Set foldexpr to treesitter
opt.foldlevel = 99 -- Start unfolded
opt.foldlevelstart = 99 -- Start unfolded
opt.foldtext = "v:lua.require'zezima.utils'.foldtext()"
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " } -- Set some invisible characters
opt.smoothscroll = true -- Smooth scrolling
opt.backspace = "indent,eol,start" -- Make backspace behave like every other editor
opt.cmdheight = 0 -- Hide command line unless needed
opt.formatexpr = "v:lua.require'conform'.formatexpr()" -- Format expression (use conform).

-- Status column (use snacks if available)
if vim.fn.exists("*v:lua.require'snacks.statuscolumn'.get") == 1 then
  opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
end

-- Highlight settings
vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })

-- Neovide
-- Helper function for transparency formatting
vim.g.neovide_opacity = 0.4
vim.g.neovide_normal_opacity = 0.4
vim.g.transparency = 0.8
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end
vim.g.neovide_background_color = "#0f1117" .. alpha()
vim.g.neovide_window_blurred = true
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_input_macos_option_key_is_meta = "only_left"

if vim.g.neovide then
  local change_transparency = function(delta)
    vim.g.neovide_opacity = vim.g.neovide_opacity + delta
    vim.g.neovide_background_color = "#0f1117" .. alpha()
  end
  vim.keymap.set({ "n", "v", "o" }, "<D-]>", function()
    change_transparency(0.01)
  end)
  vim.keymap.set({ "n", "v", "o" }, "<D-[>", function()
    change_transparency(-0.01)
  end)
end
