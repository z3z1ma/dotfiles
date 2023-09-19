require("config.lazy")

-- [[ Configure Telescope ]]
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "frecency")
pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "project")

