-- Awesome dotfile: https://github.com/yutkat/dotfiles/blob/main/.config/wezterm/wezterm.lua

-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- local scheme = wezterm.get_builtin_color_schemes()["Github (base16)"]
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
  font_size = 6,
  active_titlebar_bg = '#030303',
  inactive_titlebar_bg = '#111111',
}

config.window_background_opacity = 0.94
-- The text_background_opacity setting specifies the alpha channel value
-- to use for the background color of cells other than the default background color.
config.text_background_opacity = 0.50
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Google (dark) (terminal.sexy)'


--config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors/" }
--config.font = wezterm.font { family = 'CaskaydiaCove Nerd Font', weight = 'Regular' }
--config.font_size = 9.5 -- 8.5
config.font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Regular' }
config.font_size = 7.5 -- 8.5
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
config.hide_tab_bar_if_only_one_tab = false
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

wezterm.on('update-right-status', function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local cwd = ''
    local hostname = ''

    if type(cwd_uri) == 'userdata' then
      -- Running on a newer version of wezterm and we have a URL object here, making this simple!
      cwd = cwd_uri.file_path
      hostname = cwd_uri.host or wezterm.hostname()
    else
      -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier, which doesn't have the Url object
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find '/'
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
        -- and extract the cwd from the uri, decoding %-encoding
        cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
          return string.char(tonumber(hex, 16))
        end)
      end
    end

    -- Remove the domain name portion of the hostname
    local dot = hostname:find '[.]'
    if dot then hostname = hostname:sub(1, dot - 1) end
    if hostname == '' then hostname = wezterm.hostname() end
    table.insert(cells, cwd)
    table.insert(cells, hostname)
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  -- local colors = { '#3c1361', '#52307c', '#663a82', '#7c5295', '#b491c8', }
  local colors = { scheme.background, scheme.background, scheme.background, scheme.background, scheme.background, }

  -- Foreground color for the text across the fade
  -- local text_fg = '#c0c0c0'
  local text_fg = scheme.ansi[8]

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)

-- and finally, return the configuration to wezterm
return config
