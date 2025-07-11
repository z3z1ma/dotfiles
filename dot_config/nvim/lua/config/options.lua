vim.g.autoformat = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.lazyvim_python_lsp = "basedpyright"

vim.g.lazyvim_blink_main = false

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.autowrite = true -- Enable auto write
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)
vim.opt.completeopt = "menu,menuone,noselect,preview" -- Completion options
vim.opt.conceallevel = 0 -- Hide * markup for bold and italic
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m" -- Filename:line:column:message
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --follow" -- Use ripgrep for search
vim.opt.ignorecase = false -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.laststatus = 3 -- Always display the status line
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ " } -- Set some invisible characters
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.title = true -- Set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- What the title of the window will be set to
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.scrolloff = 8 -- Lines of context
vim.opt.sidescrolloff = 25 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" } -- Spell check
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.undodir = vim.fn.stdpath("data") .. "/.undo" -- Undo directory
vim.opt.undofile = true -- Save undo history, so that it can persist across sessions
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.splitkeep = "screen" -- Keep window layout when opening a new file
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.opt.foldmethod = "expr" -- Set foldmethod to expr
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Set foldexpr to treesitter
vim.opt.foldlevel = 99 -- Start unfolded
vim.opt.foldlevelstart = 99 -- Start unfolded
vim.opt.foldtext = "v:lua.require'zezima.utils'.ui.foldtext()"
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " } -- Set some invisible characters
vim.opt.smoothscroll = true -- Smooth scrolling
vim.opt.backspace = "indent,eol,start" -- Make backspace behave like every other editor

vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })
