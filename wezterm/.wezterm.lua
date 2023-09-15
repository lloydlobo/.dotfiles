-- Awesome dotfile: https://github.com/yutkat/dotfiles/blob/main/.config/wezterm/wezterm.lua

-- Pull in the wezterm API
local wezterm = require 'wezterm'
local scheme = wezterm.get_builtin_color_schemes()["Batman"]

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
  font_size = 8,
  active_titlebar_bg = '#030303',
  inactive_titlebar_bg = '#111111',
}

config.window_background_opacity = 0.95
-- The text_background_opacity setting specifies the alpha channel value
-- to use for the background color of cells other than the default background color.
config.text_background_opacity = 0.71
--config.color_scheme = 'Gruvbox Red'

--config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors/" }
--config.font = wezterm.font { family = 'CaskaydiaCove Nerd Font', weight = 'Regular' }
--config.font_size = 9.5 -- 8.5
config.font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Regular' }
config.font_size = 9.0 -- 8.5
--config.cell_width = 1.1
--config.line_height = 1.1
config.check_for_updates = true
config.show_update_window = true
config.use_ime = true
-- Acceptable values are SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.
--config.default_cursor_style = 'BlinkingBlock'
--config.animation_fps = 1
--config.cursor_blink_ease_in = "Constant"
--config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_rate = 800
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%"
config.window_padding = {
  --  top = 0,
  --  right = 0,
  bottom = 0,
  --  left = 0,
}
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    background = scheme.background,
    new_tab = { bg_color = "#2e3440", fg_color = scheme.ansi[8], intensity = "Bold" },
    new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
    -- format-tab-title
    -- active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
    -- inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
    -- inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
  },
}

config.window_close_confirmation = "AlwaysPrompt"
config.skip_close_confirmation_for_processes_named = {
  -- 'bash', 'sh', 'zsh', 'fish',
  'tmux', 'nu',
  'cmd.exe', 'pwsh.exe', 'powershell.exe',
}
--config.exit_behavior = "CloseOnCleanExit" -- disabled to support clean exit from $EDITOR

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = "https://github.com/$1/$3",
})

--config.enable_csi_u_key_encoding = true
--config.leader = { key = "Space", mods = "CTRL|SHIFT" }

config.disable_default_key_bindings = false

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
