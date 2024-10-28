-- Repo: https://github.com/nvim-telescope/telescope.nvim
-- Description: telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", config = false },
    { "nvim-telescope/telescope-live-grep-args.nvim", config = false },
    { "nvim-telescope/telescope-frecency.nvim", config = false },
    { "nvim-telescope/telescope-dap.nvim", config = false },
    { "nvim-telescope/telescope-project.nvim", config = false },
  },
  keys = {
    {
      "<C-p>",
      ":lua require('telescope').extensions.project.project({display_type = 'full'})<CR>",
      desc = "Open Projects",
    },
    { "<leader>ss", "<cmd>Telescope aerial<cr>", desc = "Goto Symbol (Aerial)" },
  },
  opts = {
    defaults = {
      dynamic_preview_title = true,
      hl_result_eol = true,
      sorting_strategy = "ascending",
      results_title = "",
      path_display = {
        "filename_first",
      },

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
    },
  },
}
