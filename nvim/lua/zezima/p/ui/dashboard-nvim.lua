-- Repo: https://github.com/nvimdev/dashboard-nvim
-- Description: Fancy and Blazing Fast start screen plugin for neovim

-- Get quote from https://api.quotable.io/random
local function get_quote()
  local resp = require("plenary.curl").get("https://api.quotable.io/random", { accept = "application/json" })
  local data = vim.fn.json_decode(resp.body)
  -- Perform string wrapping
  for _, v in ipairs { "content", "author" } do
    data[v] = vim.fn.split(data[v], "\n")
    for i, line in ipairs(data[v]) do
      data[v][i] = vim.fn.split(line, " ")
      local line_len = 0
      for j, word in ipairs(data[v][i]) do
        line_len = line_len + #word + 1
        if line_len > 120 then
          data[v][i][j] = "\n" .. word
          line_len = #word + 1
        end
      end
      data[v][i] = table.concat(data[v][i], " ")
    end
    data[v] = table.concat(data[v], "\n")
  end
  return data.content .. " - " .. data.author
end

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    keys = {
      { "<leader>uu", "<Cmd>Dashboard<CR>", desc = "Open dashboard" },
    },
    opts = function()
      local logo = [[
      ██╗███╗ * ██╗██╗   ██╗ ██████╗ ██╗  ██╗███████╗██████╗*
      ██║████╗  ██║██║ * ██║██╔═══██╗██║ ██╔╝██╔════╝██╔══██╗
      ██║██╔██╗ ██║██║   ██║██║ * ██║█████╔╝ █████╗  ██████╔╝
      ██║██║╚██╗██║╚██╗ ██╔╝██║   ██║██╔═██╗ ██╔══╝  ██╔══██╗
      ██║██║ ╚████║ ╚████╔╝ ╚██████╔╝██║  ██╗███████╗██║* ██║
      ╚═╝╚═╝  ╚═══╝  ╚═══╝   ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
      ]]

      local got_quote, quote = pcall(get_quote)
      if not got_quote then
        quote = "The quieter you become, the more you are able to hear."
      end
      logo = string.rep("\n", 6) .. logo .. "\n\n" .. quote .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- This is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            {
              action = [[lua require("telescope").extensions.project.project({display_type = "full"})]],
              desc = " Projects",
              icon = " ",
              key = "p",
            },
            {
              action = [[lua require("zezima.utils").telescope.config_files()()]],
              desc = " Config",
              icon = " ",
              key = "c",
            },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
