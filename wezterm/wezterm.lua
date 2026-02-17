local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local config_dir = wezterm.config_dir

config = {
  use_ime = true,
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE", -- disable the title bar but enable the resizable border
  default_cursor_style = "BlinkingBar",
  color_scheme = "Nord (Gogh)",
  -- font = wezterm.font("JetBrains Mono"),
  font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
  font_size = 13,
  background = {
    {
      source = {
        File = config_dir .. "/wallpaper-monterey.jpg"
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
      width = "100%",
      height = "100%",
    },
    {
      source = {
        Color = "#282c35"
      },
      width = "100%",
      height = "100%",
      opacity = 0.55,
    },
  },
  window_padding = {
    left = 3,
    right = 3,
    top = 0,
    bottom = 0,
  },
  keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}
}

return config
