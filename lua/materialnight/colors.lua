local util = require("materialnight.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  bg_dark = "#282828",
  bg = "#212121",
  bg_highlight = "#2d2d2d",
  terminal_black = "#282828",

  fg = "#eeffff",
  fg_dark = "#becccc",
  fg_gutter = "#424242",
  comment = "#545454",

  dark3 = "#404040",
  dark5 = "#65737e",

  blue = "#82aaff",
  blue0 = "#6888cc",
  blue1 = "#8fb3ff",
  blue2 = "#9bbbff",
  blue5 = "#a8c4ff",
  blue6 = "#b2ccd6",
  blue7 = "#415580",

  cyan = "#89ddff",

  magenta = "#c792ea",
  magenta2 = "#ddbef2",

  green = "#c3e88d",
  green1 = "#73daca",
  green2 = "#41a6b5",

  red = "#f07178",
  red1 = "#ff8b92",

  purple = "#c792ea",
  orange = "#f78c6c",
  yellow = "#ffcb6b",
  teal = "#98d3cb",

  git = { add = "#c3e88d", change = "#ffcb6b", delete = "#f07178" },
  gitSigns = { add = "#c3e88d", change = "#ffcb6b", delete = "#f07178" },
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("materialnight.config")

  local style = config.is_day() and config.options.light_style or config.options.style
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", M.default, palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.diff = {
    add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1, 0.15),
    change = util.darken(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = util.darken(colors.blue1, 0.8)
  colors.border = colors.bg_highlight

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_visual = util.darken(colors.blue0, 0.4)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  -- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
