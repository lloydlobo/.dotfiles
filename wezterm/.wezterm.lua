-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.window_frame = {
  font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Bold' },
  font_size = 8.0,
  active_titlebar_bg = '#111111',
  inactive_titlebar_bg = '#111111',
}

config.window_background_opacity = 0.85
config.text_background_opacity = 0.3 -- The text_background_opacity setting specifies the alpha channel value to use for the background color of cells other than the default background color.
config.color_scheme = 'Gruvbox Red'
config.font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Regular' }
config.font_size = 9.0

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
    --inactive_tab = {
    --  bg_color = '#2a2a2a',
    --  fg_color = '#aaaaaa',
    --}
  },
}

config.keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = '0',
    mods = 'CTRL',
    action = wezterm.action.ResetFontAndWindowSize,
  },
}

-- and finally, return the configuration to wezterm
return config
