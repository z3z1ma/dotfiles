-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Import core configuration
require("zezima.config.autocmds")
require("zezima.config.options")
require("zezima.config.keymaps")

-- Import plugins
require("zezima.plugins.theme")
require("zezima.plugins.plenary")
require("zezima.plugins.treesitter")
require("zezima.plugins.persistence")
require("zezima.plugins.snacks")
require("zezima.plugins.mini")
require("zezima.plugins.mason")
require("zezima.plugins.conform")
require("zezima.plugins.chezmoi")
require("zezima.plugins.kulala")
require("zezima.plugins.comment")
require("zezima.plugins.smear_cursor")
require("zezima.plugins.lazydev")
require("zezima.plugins.bufferline")
require("zezima.plugins.smart_splits")
require("zezima.plugins.blink")

vim.cmd([[colorscheme catppuccin]])

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

    -- Enable lsp folding
    if client:supports_method("textDocument/foldingRange") then
      vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- Enable lsp completion
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

    -- lsp toggle mappings
    vim.keymap.set("n", "<leader>uh", function()
      local new_state = not vim.lsp.inlay_hint.is_enabled()
      vim.lsp.inlay_hint.enable(new_state)
      vim.notify("Inlay Hints " .. (new_state and "enabled" or "disabled"), vim.log.levels.INFO)
    end, { desc = "Inlay Hints", buffer = event.buf })

    -- lsp goto mappings
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

    -- lsp search mappings
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
