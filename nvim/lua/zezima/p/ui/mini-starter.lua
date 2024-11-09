-- Repo: https://github.com/echasnovski/mini.starter
-- Description: Neovim Lua plugin with fast and flexible start screen. Part of 'mini.nvim' library.

-- Get quote from https://api.quotable.io/random
---@param quote_wrap_width integer
---@param left_pad integer
local function get_quote(quote_wrap_width, left_pad)
  -- Get quote
  local quote = "If you want to go fast, go alone. If you want to go far, go together. - African Proverb"
  local Curl = require("plenary.curl")
  local resp = Curl.get("https://api.quotable.io/random", {
    accept = "application/json",
    timeout = 1500,
    on_error = function()
      return nil
    end,
  })
  if resp then
    local ok, d = pcall(vim.fn.json_decode, resp.body)
    if ok then
      quote = d.content .. " - " .. d.author -- Add author to quote (with a non-breaking space)
    end
  end
  -- Perform string wrapping
  quote = vim.fn.split(quote, "\n")
  for i, line in ipairs(quote) do
    quote[i] = vim.fn.split(line, " ")
    local line_len = 0
    for j, word in ipairs(quote[i]) do
      line_len = line_len + #word + 1
      if line_len > quote_wrap_width then
        quote[i][j] = "\n" .. string.rep(" ", left_pad) .. word
        line_len = #word + left_pad + 1
      end
    end
    quote[i] = table.concat(quote[i], " ")
  end
  -- Add padding to last line of quote to make it centered, I might add this later
  -- output[#output] = string.rep(" ", math.floor((quote_wrap_width - #output[#output]) / 2)) .. output[#output]
  return table.concat(quote, "\n")
end

return {
  "echasnovski/mini.starter",
  opts = function(_, opts)
    local pad = string.rep(" ", 22)
    local new_section = function(name, action, section)
      return { name = name, action = action, section = pad .. section }
    end
    opts.items = {
      new_section("Find", LazyVim.pick(), "Telescope"),
      new_section("New", "ene | startinsert", "Built-in"),
      new_section("MRU", LazyVim.pick("oldfiles"), "Telescope"),
      new_section("Grep", LazyVim.pick("live_grep"), "Telescope"),
      new_section("Config", LazyVim.pick.config_files(), "Config"),
      new_section("Restore", [[lua require("persistence").load()]], "Session"),
      new_section("Extras", "LazyExtras", "Config"),
      new_section("Lazy", "Lazy", "Config"),
      new_section("Quit", "qa", "Built-in"),
    }
    return opts
  end,
  config = function(_, config)
    -- close Lazy and re-open when starter is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    local starter = require("mini.starter")
    starter.setup(config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function(ev)
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local p = string.rep(" ", 8)
        starter.config.header = starter.config.header .. "\n\n" .. p .. get_quote(80, 8)
        starter.config.footer = p .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        -- INFO: based on @echasnovski's recommendation (thanks a lot!!!)
        if vim.bo[ev.buf].filetype == "ministarter" then
          pcall(starter.refresh)
        end
      end,
    })
  end,
}
