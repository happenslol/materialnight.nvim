local Util = require("tokyonight.util")

---@class Palette
local palette = {
  bg = "#222436",
  bg_dark = "#1e2030",
  bg_highlight = "#2f334d",
  blue = "#82aaff",
  blue0 = "#3e68d7",
  blue1 = "#65bcff",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  comment = "#636da6",
  cyan = "#86e1fc",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  fg = "#c8d3f5",
  fg_dark = "#828bb8",
  fg_gutter = "#3b4261",
  green = "#c3e88d",
  green1 = "#4fd6be",
  green2 = "#41a6b5",
  magenta = "#c099ff",
  magenta2 = "#ff007c",
  orange = "#ff966c",
  purple = "#fca7ea",
  red = "#ff757f",
  red1 = "#c53b53",
  teal = "#4fd6be",
  terminal_black = "#444a73",
  yellow = "#ffc777",
  git = {
    add = "#b8db87",
    change = "#7ca1f2",
    delete = "#e26a75",
  },
}

local M = {}

---@type table<string, Palette|fun(opts:tokyonight.Config):Palette>
M.styles = setmetatable({}, {
  __index = function(_, style)
    return vim.deepcopy(Util.mod("tokyonight.colors." .. style))
  end,
})

---@param opts? tokyonight.Config
function M.setup(opts)
  opts = require("tokyonight.config").extend(opts)

  Util.day_brightness = opts.day_brightness

  if type(palette) == "function" then
    palette = palette(opts) --[[@as Palette]]
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = palette

  Util.bg = colors.bg
  Util.fg = colors.fg

  colors.none = "NONE"

  colors.diff = {
    add = Util.blend_bg(colors.green2, 0.15),
    delete = Util.blend_bg(colors.red1, 0.15),
    change = Util.blend_bg(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.git.ignore = colors.dark3
  colors.black = Util.blend_bg(colors.bg, 0.8, "#000000")
  colors.border_highlight = Util.blend_bg(colors.blue1, 0.8)
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = opts.styles.sidebars == "transparent" and colors.none
    or opts.styles.sidebars == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_float = opts.styles.floats == "transparent" and colors.none
    or opts.styles.floats == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_visual = Util.blend_bg(colors.blue0, 0.4)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.todo = colors.blue
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal

  colors.rainbow = { colors.blue, colors.yellow, colors.green, colors.teal, colors.magenta, colors.purple }

  opts.on_colors(colors)

  return colors, opts
end

return M
