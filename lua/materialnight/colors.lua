local util = require("materialnight.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  bg_dark = "#252525",
  bg = "#212121",
  bg_highlight = "#2d2d2d",
  terminal_black = "#282828",

  fg = "#eeffff",
  fg_dark = "#becccc",
  fg_gutter = "#424242",
  comment = "#6f6f6f",

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
  local c = vim.tbl_deep_extend("force", M.default, palette)

  c.git = { add = c.green, change = c.yellow, delete = c.red }
  c.gitSigns = c.git

  util.bg = c.bg
  util.day_brightness = config.options.day_brightness

  c.diff = {
    add = util.darken(c.green2, 0.15),
    delete = util.darken(c.red1, 0.15),
    change = util.darken(c.blue7, 0.15),
    text = c.blue7,
  }

  c.git.ignore = c.dark3
  c.black = util.darken(c.bg, 0.8, "#000000")
  c.border_highlight = util.darken(c.blue1, 0.8)
  c.border = c.bg_highlight

  -- Popups and statusline always get a dark background
  c.bg_popup = c.bg_dark
  c.bg_statusline = c.terminal_black

  -- Sidebar and Floats are configurable
  c.bg_sidebar = config.options.styles.sidebars == "transparent" and c.none
    or config.options.styles.sidebars == "dark" and c.bg_dark
    or c.bg

  c.bg_float = config.options.styles.floats == "transparent" and c.none
    or config.options.styles.floats == "dark" and c.bg_dark
    or c.bg

  c.bg_visual = util.darken(c.blue0, 0.4)
  c.bg_search = c.blue0
  c.fg_sidebar = c.fg
  c.fg_float = c.fg

  c.error = c.red
  c.warning = c.yellow
  c.info = c.blue2
  c.hint = c.teal

  c.telescope = {
    prompt_bg = c.bg_highlight,
    prompt_fg = c.fg,
    prompt_title_fg = c.bg,
    results_bg = c.bg_float,
    prompt_accent = c.blue,
    preview_accent = c.green,
  }

  c.copilot_fg = util.darken(c.comment, 0.7)

  config.options.on_colors(c)
  if opts.transform and config.is_day() then
    util.invert_colors(c)
  end

  return c
end

return M
