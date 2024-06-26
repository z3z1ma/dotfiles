-- Repo: https://github.com/neovim/nvim-lspconfig
-- Description: Quickstart configs for Nvim LSP

local Z = require("zezima.utils")

return {
  {
    -- LSP configuration & plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Mason for managing editor plugins
      "williamboman/mason.nvim",

      -- Repo: https://github.com/williamboman/mason-lspconfig.nvim
      -- Description: Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
      { "williamboman/mason-lspconfig.nvim", config = false },

      -- Repo: https://github.com/folke/neoconf.nvim
      -- Description: 💼 Neovim plugin to manage global and project-local settings
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },

      -- Repo: https://github.com/j-hui/fidget.nvim
      -- Description: Standalone UI for nvim-lsp progress
      { "j-hui/fidget.nvim", opts = {} },

      -- Repo: https://github.com/folke/lazydev.nvim
      -- Description: 💻 Faster LuaLS setup for Neovim
      { "folke/lazydev.nvim", ft = "lua", opts = {} },

      -- Repo: https://github.com/hrsh7th/cmp-nvim-lsp
      -- Description: nvim-cmp source for neovim builtin LSP clien
      { "hrsh7th/cmp-nvim-lsp", opts = {} },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true, -- requires 0.10.0 build
      },
      capabilities = {}, -- add any global capabilities here
      autoformat = true, -- autoformat on save
      format_notify = false, -- show a notification when formatting
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the custom formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = 5000,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        rust_analyzer = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              telemetry = { enable = false },
              library = {
                -- Make the server aware of Neovim runtime files
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua",
              },
              diagnostics = {
                globals = { "vim", "require", "pcall", "pairs" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
              },
              format = {
                enable = false,
              },
            },
          },
        },
        pyright = {
          capabilities = {
            textDocument = {
              publishDiagnostics = {
                tagSupport = { valueSet = { 2 } },
              },
            },
          },
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportPrivateImportUsage = "none",
                },
                autoImportCompletion = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixfmt" } },
            },
          },
        },
        elixirls = {},
        clojure_lsp = {},
        zls = {},
        yamlls = {},
      },
    },
    config = function(_, opts)
      -- Configure lsps locally
      if Z.lazy.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- Setup autoformat
      local format_handler = require("zezima.format")
      format_handler.setup(opts)
      format_handler.register(Z.lsp.formatter({}))

      -- Add hooks to on_attach
      Z.lsp.on_attach(function(client, buffer) ---@diagnostic disable-line: unused-local
        if client.name == "ruff_lsp" then
          -- disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end)

      -- Add hooks to registerCapability handler
      local register_capability = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id) ---@diagnostic disable-line: unused-local
        local buffer = vim.api.nvim_get_current_buf() ---@diagnostic disable-line: unused-local
        -- Add behavior here...
        return ret
      end

      -- Diagnostics
      for name, icon in pairs(require("zezima.constants").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      -- Inlay hints if enabled
      local inlay_hint = vim.lsp.inlay_hint.enable
      if opts.inlay_hints.enabled and inlay_hint then
        Z.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(true, { bufnr = buffer })
          end
        end)
      end

      -- Virtual text icons if enabled
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("zezima.constants").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      -- Main setup call
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities or {}),
        }, servers[server] or {})
        server_opts.flags = { debounce_text_changes = 150 }
        require("lspconfig")[server].setup(server_opts)
      end

      -- Get all the servers that are available through mason-lspconfig
      local has_mason, mason_lsp = pcall(require, "mason-lspconfig")
      local mason_servers = {}
      if has_mason then
        mason_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- Run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(mason_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if has_mason then
        mason_lsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
          automatic_installation = true,
        })
      end

      if Z.lsp.get_config("denols") and Z.lsp.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Z.lsp.disable("tsserver", is_deno)
        Z.lsp.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
}
