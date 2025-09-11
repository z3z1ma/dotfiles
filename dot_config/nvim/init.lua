-- Enable luajit caching
vim.loader.enable()

pcall(function()
  require("jit.opt").start(
    "hotloop=48",
    "hotexit=8",
    "hotcall=48",
    "maxrecord=2800",
    "sizemcode=1536", -- reduce eviction churn
    "maxmcode=65536" -- avoid flushes
  )
end)

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Skip builtin plugins
vim.opt.loadplugins = false

-- Disable some unused features
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Core runtime plugins I don't use
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_matchit = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_tohtml = 1

-- Load a configuration module
local function config(module)
  return require("zezima.config." .. module)
end

-- Load a plugin definition module
local function plugin(opts)
  local function _lazy(fn, delay_ms)
    if delay_ms and delay_ms > 0 then
      vim.defer_fn(fn, delay_ms)
    else
      vim.schedule(fn)
    end
  end
  if type(opts) == "string" then
    opts = { module = opts }
  end
  local module = opts.module or opts[1]
  if opts.defer then
    _lazy(function()
      require("zezima.plugins." .. module)
    end, type(opts.delay_ms) == "number" and opts.delay_ms or 25)
  else
    require("zezima.plugins." .. module)
  end
end

-- Load a plugin definition module with an enable command
-- This is useful for plugins that are not always needed
local function plugin_with_enable_cmd(cmd, opts)
  local title = cmd:gsub("^%l", string.upper)
  vim.api.nvim_create_user_command("Enable" .. title, function()
    plugin(opts or cmd)
    vim.api.nvim_del_user_command("Enable" .. title)
    vim.notify(title .. " enabled", vim.log.levels.INFO)
  end, {})
end

-- Import core configuration
config("autocmds")
config("options")
config("keymaps")

-- Import plugins
plugin("theme")
plugin("snacks")
plugin("mini")

plugin({ "mason", defer = true })
plugin({ "treesitter", defer = true })

plugin({ "blink", defer = true })
plugin({ "chezmoi", defer = true })
plugin({ "claude", defer = true })
plugin({ "conform", defer = true })
plugin({ "gitsigns", defer = true, delay_ms = 500 })
plugin({ "grug_far", defer = true })
plugin({ "harpoon", defer = true })
plugin({ "lazydev", defer = true })
plugin({ "leap", defer = true })
plugin({ "parinfer", defer = true })
plugin({ "persistence", defer = true })
plugin({ "rainbow", defer = true })
plugin({ "smart_splits", defer = true })
plugin({ "smear_cursor", defer = true })
plugin({ "vim_fugitive", defer = true })
plugin({ "wakatime", defer = true })

plugin_with_enable_cmd("conjure")
plugin_with_enable_cmd("kulala")
plugin_with_enable_cmd("dropbar")

-- Import user commands
config("usercmds")

vim.lsp.enable({
  "bashls",
  "clangd",
  "clojure_lsp",
  "cmake",
  "copilot",
  "lua_ls",
  "nil_ls",
  "ruff",
  "rust_analyzer",
  "ty",
})

local icons = require("zezima.icons")
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  float = {
    border = "single",
    focusable = false,
  },
  jump = {
    _highest = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
})

vim.lsp.semantic_tokens.enable(false)

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

    -- Enable LSP folding
    if client:supports_method("textDocument/foldingRange") then
      vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- Enable LSP completion
    if client:supports_method("textDocument/completion") then
      vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.lsp.completion.enable(true, client.id, event.buf, {
        convert = function(item)
          local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "Unknown"
          local icon = require("zezima.icons").kinds[kind]
          return {
            kind = icon and icon .. " " .. kind or kind,
          }
        end,
      })
    end

    -- LSP toggle mappings
    vim.keymap.set("n", "<leader>uh", function()
      local new_state = not vim.lsp.inlay_hint.is_enabled()
      vim.lsp.inlay_hint.enable(new_state)
      vim.notify("Inlay Hints " .. (new_state and "enabled" or "disabled"), vim.log.levels.INFO)
    end, { desc = "Inlay Hints", buffer = event.buf })

    -- LSP goto mappings
    vim.keymap.set("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, { desc = "Goto Definition", buffer = event.buf })
    vim.keymap.set("n", "gr", function()
      Snacks.picker.lsp_references()
    end, { desc = "References", buffer = event.buf, nowait = true })
    vim.keymap.set("n", "gI", function()
      Snacks.picker.lsp_implementations()
    end, { desc = "Goto Implementation", buffer = event.buf })
    vim.keymap.set("n", "gy", function()
      Snacks.picker.lsp_type_definitions()
    end, { desc = "Goto T[y]pe Definition", buffer = event.buf })
    vim.keymap.set("n", "gD", function()
      Snacks.picker.lsp_declarations()
    end, { desc = "Goto Declarations", buffer = event.buf })
    vim.keymap.set("n", "K", function()
      return vim.lsp.buf.hover()
    end, { desc = "Hover", buffer = event.buf })
    vim.keymap.set("n", "gK", function()
      return vim.lsp.buf.signature_help()
    end, { desc = "Signature Help", buffer = event.buf })

    -- LSP search mappings
    local misc = require("zezima.misc")
    vim.keymap.set("n", "<leader>ss", function()
      Snacks.picker.lsp_symbols({ filter = misc.lsp_kind_filter })
    end, { desc = "LSP Symbols", buffer = event.buf })
    vim.keymap.set("n", "<leader>sS", function()
      Snacks.picker.lsp_workspace_symbols({ filter = misc.kind_filter })
    end, { desc = "LSP Workspace Symbols", buffer = event.buf })

    -- lsp code mappings
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = event.buf })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = event.buf })
  end,
})
