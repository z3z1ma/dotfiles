local Z = require("zezima.utils")

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Better left/right
-- vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
-- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
-- vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

-- Easy route to normal mode
vim.keymap.set("i", "jj", "<Esc>")

-- Select all
vim.keymap.set({ "n", "v" }, "<C-a>", "ggVG", { silent = true })

-- Center the view after jumping up/down
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move to window using the <ctrl> hjkl keys (with Tmux support)
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><C-h>", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><C-j>", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><C-k>", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><C-l>", require("smart-splits").swap_buf_right)

-- Move Lines
vim.keymap.set("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
-- vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- keywordprg
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quickfix
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Toggle options
vim.keymap.set("n", "<leader>uf", function()
  require("zezima.format").toggle()
end, { desc = "Toggle auto format (global)" })
vim.keymap.set("n", "<leader>uF", function()
  require("zezima.format").toggle(true)
end, { desc = "Toggle auto format (buffer)" })
vim.keymap.set("n", "<leader>us", function()
  Z.vim.toggle_opt("spell")
end, { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>uw", function()
  Z.vim.toggle_opt("wrap")
end, { desc = "Toggle Word Wrap" })
vim.keymap.set("n", "<leader>ul", Z.vim.toggle_number, { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>ud", Z.vim.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set("n", "<leader>uc", function()
  Z.vim.toggle_opt("conceallevel", { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", function()
  Z.vim.float_term({ "lazygit" }, { cwd = Z.get_root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (root dir)" })
vim.keymap.set("n", "<leader>gG", function()
  Z.vim.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
vim.keymap.set("n", "<leader>gH", function()
  Z.vim.float_term({ "harness-tui" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Highlights under cursor
vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Floating terminal
local root_term = function()
  Z.vim.float_term(nil, { cwd = Z.get_root() })
end
vim.keymap.set("n", "<leader>ft", root_term, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>fT", Z.vim.float_term, { desc = "Terminal (cwd)" })
vim.keymap.set("n", "<C-/>", root_term, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<C-_>", root_term, { desc = "which_key_ignore" })

-- Terminal Mappings
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- LSP
Z.lsp.on_attach(function(client, buffer)
  vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = buffer })
  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = buffer })
  vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end, {
    desc = "Goto Definition",
    buffer = buffer,
  })
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", buffer = buffer })
  vim.keymap.set("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, {
    desc = "Goto Implementation",
    buffer = buffer,
  })
  vim.keymap.set("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, {
    desc = "Goto T[y]pe Definition",
    buffer = buffer,
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buffer })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = { only = { "source" }, diagnostics = {} },
    })
  end, { desc = "Source Action", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer })
  if vim.lsp.inlay_hint then
    vim.keymap.set("n", "<leader>uh", function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = "Toggle Inlay Hints" })
  end
end)

-- Jump to next/prev diagnostic
---@param next boolean
---@param severity? "ERROR"|"WARN"
local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  local level = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = level })
  end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Format
vim.keymap.set("n", "<leader>cf", function()
  local has_conform, conform = pcall(require, "conform")
  if has_conform then
    conform.format({ lsp_fallback = true })
  else
    vim.lsp.buf.format()
  end
end, { desc = "Format Document" })
vim.keymap.set("v", "<leader>cf", function()
  Z.try(vim.lsp.buf.range_format, {})
end, { desc = "Format Range" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "D", '"_D', { desc = "Delete without yanking" })

-- Send yanked text to a relative tmux pane, useful when running a REPL like python or clojure
local function send_to_tmux_pane(key, direction)
  vim.keymap.set(
    "n",
    "<leader>w" .. key,
    "<cmd>silent !tmux pasteb -t " .. direction .. "<cr>",
    { desc = "Send last yanked text to " .. direction .. " tmux pane" }
  )
  vim.keymap.set(
    "n",
    "<leader>w" .. key:upper(),
    "yy<cmd>silent !tmux pasteb -t " .. direction .. "<cr>",
    { desc = "Send current line to " .. direction .. " tmux pane" }
  )
  vim.keymap.set(
    "v",
    "<leader>w" .. key,
    "y<cmd>silent !tmux pasteb -t " .. direction .. "<cr>",
    { desc = "Send selected text to " .. direction .. " tmux pane" }
  )
end

send_to_tmux_pane("h", "left")
send_to_tmux_pane("j", "down")
send_to_tmux_pane("k", "up")
send_to_tmux_pane("l", "right")

-- Use (,[,{,",' in visual mode to wrap using mini.surround
vim.keymap.set("v", "(", "gza(", { desc = "Wrap in ()", remap = true })
vim.keymap.set("v", "[", "gza[", { desc = "Wrap in []", remap = true })
vim.keymap.set("v", "'", "gza'", { desc = "Wrap in ''", remap = true })
vim.keymap.set("v", '"', 'gza"', { desc = 'Wrap in ""', remap = true })

-- Search but keep cursor position
vim.keymap.set("n", "*", ":silent keepjumps normal! mi*`i<CR>", { remap = false, silent = true })

vim.keymap.set("n", "<C-CR>", "ciw", { desc = "Change inner word" })
vim.keymap.set("n", "<C-BS>", "dbx", { desc = "Delete backwards word" })
