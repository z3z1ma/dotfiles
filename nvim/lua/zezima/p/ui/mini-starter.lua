-- Repo: https://github.com/nvimdev/dashboard-nvim
-- Description: Fancy and Blazing Fast start screen plugin for neovim

-- Get quote from https://api.quotable.io/random
local function get_quote(quote_wrap_width)
  local got_quote, quote = pcall(function()
    -- Get quote
    local resp = require("plenary.curl").get("https://api.quotable.io/random", { accept = "application/json" })
    local data = vim.fn.json_decode(resp.body)

    -- Add author to quote (with a non-breaking space)
    local output = data.content .. " - " .. data.author

    -- Perform string wrapping
    output = vim.fn.split(output, "\n")
    for i, line in ipairs(output) do
      output[i] = vim.fn.split(line, " ")
      local line_len = 0
      for j, word in ipairs(output[i]) do
        line_len = line_len + #word + 1
        if line_len > quote_wrap_width then
          output[i][j] = "\n" .. word
          line_len = #word + 1
        end
      end
      output[i] = table.concat(output[i], " ")
    end
    -- Add padding to last line of quote to make it centered, I might add this later
    -- output[#output] = string.rep(" ", math.floor((quote_wrap_width - #output[#output]) / 2)) .. output[#output]
    output = table.concat(output, "\n")

    return output
  end)

  if not got_quote then
    quote = "The quieter you become, the more you are able to hear."
  end

  return quote
end

local daysofweek = {
  Monday = [[
███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗
████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀
██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Tuesday = [[
████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀
   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀
   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Wednesday = [[
██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀
██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀
 ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Thursday = [[
████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝⠀
   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║⠀⠀⠀
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Friday = [[
███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝
█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝⠀
██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
██║     ██║  ██║██║██████╔╝██║  ██║   ██║⠀⠀⠀
╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Saturday = [[
███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝⠀
╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝⠀⠀
███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║⠀⠀⠀
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Sunday = [[
███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀
╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀
╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
}

local align = function()
  local horiz_coef = 0.5
  local vert_coef = 0.5

  return function(content, buf_id)
    local win_id = vim.fn.bufwinid(buf_id)
    if win_id < 0 then
      return
    end
    assert(win_id ~= nil, "Invalid buffer id")

    local line_strings = require("mini.starter").content_to_lines(content)

    -- Align horizontally
    -- Don't use `string.len()` to account for multibyte characters
    local lines_width = vim.tbl_map(function(l)
      return vim.fn.strdisplaywidth(l)
    end, line_strings)
    local min_right_space = vim.api.nvim_win_get_width(win_id) - math.max(unpack(lines_width))
    local left = math.max(math.floor(horiz_coef * min_right_space), 0)

    -- Add left padding
    local left_pad = string.rep(" ", left)
    for _, line in ipairs(content) do
      local is_empty_line = #line == 0 or (#line == 1 and line[1].string == "")
      if not is_empty_line then
        table.insert(line, 1, { string = left_pad, type = "empty" })
      end
    end

    -- Align vertically
    local bottom_space = vim.api.nvim_win_get_height(win_id) - #line_strings
    local top_lines = {}
    for _ = 1, math.max(math.floor(vert_coef * bottom_space), 0) do
      table.insert(top_lines, { { string = "", type = "empty" } })
    end
    content = vim.list_extend(top_lines, content)

    return content
  end
end

return {
  {
    "echasnovski/mini.starter",
    version = false,
    keys = {
      {
        "<leader>uu",
        function()
          require("mini.starter").open()
          require("mini.starter").refresh()
        end,
        desc = "Open dashboard",
      },
    },
    event = "VimEnter",
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        header = function()
          local dow = daysofweek[os.date("%A")]
          local width = 0
          for _, line in ipairs(vim.split(dow, "\n", { trimempty = true })) do
            -- get display width of line
            local line_width = vim.fn.strdisplaywidth(line)
            width = line_width > width and line_width or width
          end
          local quote = get_quote(width + 2)
          local date = os.date(" %A, %B %d, %Y")
          local cwd = " " .. vim.fn.pathshorten(vim.fn.getcwd()) .. " (cwd)"
          return table.concat({
            dow,
            string.rep(" ", math.floor((width - #date) / 2)) .. date,
            string.rep(" ", math.floor((width - #cwd) / 2)) .. cwd,
            "",
            quote,
          }, "\n")
        end,
        items = {
          { action = "Telescope find_files", name = "Files", section = " Telescope" },
          { action = "Telescope oldfiles", name = "Recent", section = " Telescope" },
          {
            action = [[lua require("telescope").extensions.project.project({display_type = "full"})]],
            name = "Projects",
            section = " Telescope",
          },
          {
            action = [[lua require("zezima.utils").telescope.config_files()()]],
            name = "Config",
            section = " Telescope",
          },
          { action = "ene | startinsert", name = "New", section = " Edit" },
          { action = "Lazy", name = "Lazy", section = "󰒲 Plugins" },
          {
            action = [[lua require("persistence").load()]],
            name = "Session",
            section = " Restore",
          },
          { action = "qa", name = "Quit", section = " Exit Neovim" },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(" "),
          align(),
          -- starter.gen_hook.aligning("center", "center"),
          -- function(content)
          --   local coords = MiniStarter.content_coords(content, "item_bullet")
          --   for i = #coords, 1, -1 do
          --     local l_num, u_num = coords[i].line, coords[i].unit
          --     content[l_num][u_num].string = lpad .. content[l_num][u_num].string
          --   end
          --   coords = MiniStarter.content_coords(content, "section")
          --   for i = #coords, 1, -1 do
          --     local l_num, u_num = coords[i].line, coords[i].unit
          --     content[l_num][u_num].string = lpad .. content[l_num][u_num].string
          --   end
          --   return content
          -- end,
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local version = vim.version()
          local version_info = string.format(
            "  v%d.%d.%d%s",
            version.major,
            version.minor,
            version.patch,
            version.prerelease and " (nightly)" or ""
          )
          return "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms\n"
            .. version_info
        end,
      })
    end,
  },
}
