local colors = require("materialnight.colors").setup({ transform = true })
local config = require("materialnight.config").options

local materialnight = {}

materialnight.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.blue },
  c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
}

materialnight.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.green },
}

materialnight.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.yellow },
}

materialnight.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.magenta },
}

materialnight.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.red },
}

materialnight.terminal = {
  a = {bg = colors.green1, fg = colors.black },
  b = {bg = colors.fg_gutter, fg=colors.green1 },
}

materialnight.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.comment, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.comment },
}

if config.lualine_bold then
  for _, mode in pairs(materialnight) do
    mode.a.gui = "bold"
  end
end

return materialnight
