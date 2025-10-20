vim.pack.add({
  {
    src = "https://github.com/alker0/chezmoi.vim",
    version = "ca5f2ed602046d5662cb76d845c4b510aae0ce84",
  },
  {
    src = "https://github.com/xvzc/chezmoi.nvim",
    version = "8b426285c2b0acb9b0dd46789193fa97f6480b99",
  },
})

require("zezima.plugins.plenary") -- Dependency: chezmoi uses plenary

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

  for _, dotf in ipairs(results) do
    table.insert(items, { text = dotf, file = dotf })
  end

  require("mini.pick").start({
    source = {
      name = "Chezmoi",
      items = items,
      choose = function(item)
        require("chezmoi.commands").edit({
          targets = { item.text },
          args = { "--watch" },
        })
        vim.schedule(function()
          vim.cmd("edit " .. item.file)
        end)
        return false
      end,
    },
  })
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
