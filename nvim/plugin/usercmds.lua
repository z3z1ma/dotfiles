-- Toggle transparency in catppuccin
vim.api.nvim_create_user_command("CatppuccinTransparency", function()
  local cat = require("catppuccin")
  cat.options.transparent_background = not cat.options.transparent_background
  cat.compile()
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })

-- Open messages in a split, these include command output
vim.api.nvim_create_user_command("Messages", function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd([[put= execute('messages')]])
  end)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
  vim.cmd.split()
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(winnr, bufnr)
end, {})

-- Edit snippets
vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files({
    extend = function(ft, paths)
      if ft == "" then
        ft = "all"
      end
      if #paths == 0 then
        return {
          {
            vim.fn.stdpath("config") .. "/snippets/" .. ft .. ".snippets",
            vim.fn.stdpath("config") .. "/snippets/" .. ft .. ".lua",
          },
        }
      end

      return {}
    end,
  })
end, {})
