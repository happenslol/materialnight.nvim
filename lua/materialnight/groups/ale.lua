local M = {}

M.url = "https://github.com/dense-analysis/ale"

---@type materialnight.HighlightsFn
function M.get(c, opts)
  -- stylua: ignore
  return {
    ALEErrorSign   = { fg = c.error },
    ALEWarningSign = { fg = c.warning },
  }
end

return M
