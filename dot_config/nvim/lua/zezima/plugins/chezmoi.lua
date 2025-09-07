vim.pack.add({
  {
    src = "https://github.com/alker0/chezmoi.vim",
    version = "abf37336437867cbd99ce2f8849b717415391cc3",
  },
  {
    src = "https://github.com/xvzc/chezmoi.nvim",
    version = "e0b3ebafd910b63acdfbf6677b44b03eb3d09f19",
  },
})

vim.g["chezmoi#use_tmp_buffer"] = 1
vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"

local pick_chezmoi = function()
  local results = require("chezmoi.commands").list({
    args = {
      "--path-style",
      "absolute",
      "--include",
      "files",
      "--exclude",
      "externals",
    },
  })
  local items = {}

  for _, czFile in ipairs(results) do
    table.insert(items, {
      text = czFile,
      file = czFile,
    })
  end

  ---@type snacks.picker.Config
  local opts = {
    items = items,
    confirm = function(picker, item)
      picker:close()
      require("chezmoi.commands").edit({
        targets = { item.text },
        args = { "--watch" },
      })
    end,
  }

  Snacks.picker.pick(opts)
end

local chezmoi = require("chezmoi")

chezmoi.setup({
  edit = {
    watch = false,
    force = false,
  },
  notification = {
    on_open = true,
    on_apply = true,
    on_watch = false,
  },
  telescope = {
    select = { "<CR>" },
  },
})

-- Run chezmoi edit on file enter
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function()
    vim.schedule(require("chezmoi.commands.__edit").watch)
  end,
})

vim.keymap.set("", "<leader>sz", pick_chezmoi, { desc = "Chezmoi" })
