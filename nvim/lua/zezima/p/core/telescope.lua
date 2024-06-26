local Z = require("zezima.utils")

-- Repo: https://github.com/nvim-telescope/telescope.nvim
-- Description: telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- Telescope has one release, so use HEAD for now
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", config = false },
      { "nvim-telescope/telescope-live-grep-args.nvim", config = false },
      { "nvim-telescope/telescope-frecency.nvim", config = false },
      { "nvim-telescope/telescope-dap.nvim", config = false },
      { "nvim-telescope/telescope-project.nvim", config = false },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("frecency")
      telescope.load_extension("project")
      telescope.load_extension("aerial")
      telescope.load_extension("yank_history")
    end,
    -- stylua: ignore start
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Z.telescope.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", Z.telescope.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", Z.telescope.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", Z.telescope.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fA", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "Find files (all)" }},
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", Z.telescope.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Grep (with args)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", Z.telescope.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Z.telescope.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", Z.telescope.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>sW", Z.telescope.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", Z.telescope.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", Z.telescope.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", Z.telescope.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        Z.telescope.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Z.telescope.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
      { "<C-p>", ":lua require('telescope').extensions.project.project({display_type = 'full'})<CR>", desc = "Open Projects" },
      { "<leader>ss", "<cmd>Telescope aerial<cr>", desc = "Goto Symbol (Aerial)" },
    },
    -- stylua: ignore end
    opts = function()
      local ui_config = z3.styles.transparent and { defaults = { prompt_prefix = " ", selection_caret = " " } }
        or {
          defaults = {
            -- Experimental new UI
            prompt_prefix = "   ",
            selection_caret = "  ",
            path_display = {
              "filename_first",
            },
            -- entry_prefix = "   ",
            -- borderchars = {
            --   prompt = Z.generate_borderchars(
            --     "thick",
            --     nil,
            --     { top = "█", top_left = "█", left = "█", right = " ", top_right = " ", bottom_right = " " }
            --   ),
            --   results = Z.generate_borderchars(
            --     "thick",
            --     nil,
            --     { top = "█", top_left = "█", right = " ", top_right = " ", bottom_right = " " }
            --   ),
            --   preview = Z.generate_borderchars("thick", nil, { top = "█", top_left = "█", top_right = "█" }),
            -- },
          },
        }

      return vim.tbl_deep_extend("force", ui_config, {
        defaults = {
          dynamic_preview_title = true,
          hl_result_eol = true,
          sorting_strategy = "ascending",
          results_title = "",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = {
            ".git/",
            ".github/",
            "vendor/",
            "target/",
            "__pycache__/",
            "node_modules/",
            "%.sqlite3",
            "%.duckdb",
            "%.lock",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.svg",
            "%.otf",
            "%.ttf",
            "%.webp",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "%.mp4",
            "%.mkv",
            "%.rar",
            "%.zip",
            "%.7z",
            "%.tar",
            "%.bz2",
            "%.epub",
            "%.flac",
            "%.tar.gz",
          },

          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
              end,
              ["<a-i>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Z.telescope.telescope("find_files", { no_ignore = true, default_text = line })()
              end,
              ["<a-h>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Z.telescope.telescope("find_files", { no_ignore = true, hidden = true, default_text = line })()
              end,
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
              ["<C-d"] = "delete_buffer",
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
              ["d"] = "delete_buffer",
            },
          },
        },
        extensions = {
          project = {
            base_dirs = {
              { vim.fn.expand("$HOME/code_projects/work"), max_depth = 3 },
              { vim.fn.expand("$HOME/code_projects/personal"), max_depth = 3 },
            },
            on_project_selected = function(prompt_bufnr)
              vim.cmd("Neotree close")
              require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
              require("mini.starter").close()
              vim.cmd("silent! %bd")
              vim.cmd("silent! only")
              require("persistence").load()
              vim.cmd("VenvSelectCached")
              local bufs = vim.fn.getbufinfo({ buflisted = 1 })
              if bufs ~= nil and vim.tbl_isempty(bufs) then
                vim.cmd("Neotree reveal")
              end
            end,
          },
        },
      })
    end,
  },
}
