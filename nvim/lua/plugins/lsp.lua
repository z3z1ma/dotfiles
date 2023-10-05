local M = {
  {
    -- LSP configuration & plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- mason for managing editor plugins
      "mason.nvim",

      -- automatically install LSPs to stdpath for neovim
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "pyright",
            "rust_analyzer",
            "gopls",
            "lua_ls",
            "ruff_lsp",
            "efm",
            "zls",
            "nil_ls",
            "clojure_lsp",
            "elixirls",
            "jsonls",
            "yamlls",
          },
          automatic_installation = true,
        },
      },

      -- configure LSPs with json
      { "folke/neoconf.nvim",              cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },

      -- useful status updates for LSP
      { "j-hui/fidget.nvim",               tag = "legacy",  opts = {} },

      -- additional lua configuration, makes nvim stuff amazing
      { "folke/neodev.nvim",               opts = {} },

      -- language server for pluggable providers
      { "creativenull/efmls-configs-nvim", config = false },

      -- autocompletions
      { "hrsh7th/cmp-nvim-lsp",            config = true },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,      -- requires 0.10.0 build
      },
      capabilities = {},     -- add any global capabilities here
      autoformat = true,     -- autoformat on save
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
                rangeVariableTypes = true
              }
            }
          }
        },
        rust_analyzer = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
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
            },
          },
        },
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                autoImportCompletion = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                stubPath = vim.fn.expand("~/.config/nvim/stubs"),
              },
            },
          },
        },
        ruff_lsp = {},
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixfmt" } }
            }
          }
        },
        efm = {
          filetypes = { "python", "sql" },
          init_options = { documentFormatting = true, documentRangeFormatting = true },
          settings = {
            languages = {
              python = {
                require("plugins.lsp_config.formatters.black"),
                require("plugins.lsp_config.formatters.isort"),
                require("plugins.lsp_config.formatters.ruff"),
              },
              sql = {
                require("plugins.lsp_config.formatters.sqlfmt"),
              },
            },
          },
        },
        elixirls = {},
        clojure_lsp = {},
        zls = {},
        yamlls = {}
      },
      setup = {
        ["ruff_lsp"] = function()
          require("util").on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
    config = function(_, opts)
      if require("util").has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- setup autoformat
      require("plugins.lsp_config.format").setup(opts)

      -- setup keymaps
      require("util").on_attach(function(client, buffer)
        require("plugins.lsp_config.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("plugins.lsp_config.keymaps").on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      for name, icon in pairs(require("config.constants").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      -- inlay hints if enabled
      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      if opts.inlay_hints.enabled and inlay_hint then
        require("util").on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(buffer, true)
          end
        end)
      end

      -- virtual text icons if enabled
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
            or function(diagnostic)
              local icons = require("config.constants").icons.diagnostics
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

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local has_mason, mason_lsp = pcall(require, "mason-lspconfig")
      local mason_servers = {}
      if has_mason then
        mason_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(mason_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if has_mason then
        mason_lsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if require("util").lsp_get_config("denols") and require("util").lsp_get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        require("util").lsp_disable("tsserver", is_deno)
        require("util").lsp_disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
}

return M
