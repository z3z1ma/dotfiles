vim.pack.add({
  {
    src = "https://github.com/tpope/vim-rhubarb",
    version = "5496d7c94581c4c9ad7430357449bb57fc59f501",
  },
  {
    src = "https://github.com/tpope/vim-fugitive",
    version = "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4",
  },
})

vim.keymap.set("", "<leader>gL", function()
  vim.cmd([[Git log --oneline --decorate --graph --all]])
end, { desc = "Git log" })
vim.keymap.set("", "<leader>gl", function()
  vim.cmd([[Git log -- %]])
end, { desc = "Git history (buffer)" })
vim.keymap.set("", "<leader>gd", function()
  vim.cmd([[Gdiff]])
end, { desc = "Git diff" })
vim.keymap.set("", "<leader>gs", function()
  vim.cmd([[Git]])
end, { desc = "Git status" })
vim.keymap.set("", "<leader>gc", function()
  vim.cmd([[Git commit]])
end, { desc = "Git commit" })
vim.keymap.set("", "<leader>gp", function()
  vim.cmd([[Git push]])
end, { desc = "Git push" })
vim.keymap.set("", "<leader>gb", function()
  vim.cmd([[Git blame]])
end, { desc = "Git blame" })
vim.keymap.set("", "<leader>gC", function()
  local branches = {}
  for line in io.popen("git branch --all --format='%(refname:short)'"):lines() do
    table.insert(branches, line)
  end
  vim.ui.select(branches, { prompt = "Select a branch to checkout:" }, function(choice)
    if choice then
      vim.cmd("Git checkout " .. choice)
      vim.notify("Checked out to branch: " .. choice)
    else
      vim.notify("No branch selected")
    end
  end)
end, { desc = "Git checkout" })
vim.keymap.set("", "<leader>gB", function()
  local branches = {}
  for line in io.popen("git branch --all --format='%(refname:short)'"):lines() do
    table.insert(branches, line)
  end
  vim.ui.select(branches, { prompt = "Select a branch to create from:" }, function(choice)
    if choice then
      vim.schedule(function()
        vim.cmd([[startinsert]])
      end)
      vim.ui.input({ prompt = "Enter new branch name: " }, function(new_branch)
        if new_branch ~= "" then
          vim.cmd("Git checkout -b " .. new_branch .. " " .. choice)
          vim.notify("Created and checked out to new branch " .. new_branch .. " from " .. choice)
        else
          vim.notify("Branch creation cancelled: No name provided")
        end
      end)
    else
      vim.notify("No base branch selected")
    end
  end)
end, { desc = "Git branch" })
