local version = "v1.6.0"
vim.g.blink_cmp_version = version

vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("BlinkUpdated", { clear = true }),
  callback = function(args)
    if vim.g.blink_cmp_version:find("^v") then
      return
    end
    local spec = args.data.spec
    if spec and spec.name == "blink.cmp" and args.data.kind ~= "delete" then
      vim.system({ "cargo", "+nightly", "build", "--release" }, { cwd = args.data.path }, function(rv)
        if rv.code ~= 0 then
          vim.notify(rv.stderr, vim.log.levels.WARN)
        end
      end)
    end
  end,
})

vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = version,
  },
})

local has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

local blink = require("blink.cmp")
local blink_cmp_list = require("blink.cmp.completion.list")
local blink_cmp_trigger = require("blink.cmp.completion.trigger")

blink.setup({
  snippets = {
    preset = "mini_snippets",
  },
  signature = { enabled = true },
  keymap = {
    preset = "none",
    ["<Tab>"] = {
      function(cmp)
        if not has_words_before() then
          return vim.lsp.inline_completion.get()
        elseif #cmp.get_items() == 0 then
          cmp.show_and_insert()
        else
          vim.schedule(function()
            if blink_cmp_list.is_explicitly_selected then
              blink_cmp_list.select_next()
            else
              blink_cmp_list.select(1)
            end
          end)
        end
        return true
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if not cmp.get_selected_item() then
          local ok, did_accept = pcall(vim.lsp.inline_completion.get)
          return ok and did_accept
        end
      end,
      "insert_prev",
      "fallback",
    },
    ["<Enter>"] = {
      function(cmp)
        if cmp.get_selected_item() then
          vim.schedule(function()
            blink_cmp_list.accept()
            blink_cmp_trigger.hide()
          end)
          return true
        end
        return false
      end,
      "fallback",
    },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-y>"] = { "select_and_accept" },
    ["<C-p>"] = { "snippet_backward", "fallback_to_mappings" },
    ["<C-n>"] = { "snippet_forward", "fallback_to_mappings" },
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  completion = {
    menu = { enabled = true, auto_show = false },
    list = { selection = { preselect = false }, cycle = { from_top = false } },
    ghost_text = {
      enabled = function()
        return not vim.lsp.inline_completion.is_enabled({ bufnr = 0 })
      end,
      show_without_selection = true,
    },
  },
  sources = {
    per_filetype = {
      lua = {
        inherit_defaults = true,
        "lazydev",
      },
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
        async = true,
      },
      lsp = {
        async = true,
        score_offset = 50,
      },
    },
  },
})
