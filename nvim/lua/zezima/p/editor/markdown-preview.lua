-- Repo: https://github.com/iamcco/markdown-preview.nvim
-- Description: Preview Markdown in your modern browser with synchronised scrolling and flexible configuration.
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
