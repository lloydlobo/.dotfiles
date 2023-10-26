-- Wezterm API
local wezterm = require 'wezterm'

-- Main table to hold all configurations
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local scheme = {}  -- Used for color theme reference
local schemes = {} -- Hold all schemes as enums

-- Define a function to generate an enum and its string representation
local function add_scheme(name)
  return { name = name, value = #schemes + 1 }
end

-- Define color schemes as enums
schemes.Batman                        = add_scheme("Batman")
schemes.SolarizedDark                 = add_scheme("Builtin Solarized Dark")
schemes.GithubBase16                  = add_scheme("Github (base16)")
schemes.SolarizedDarkGogh             = add_scheme("Solarized Dark (Gogh)")
schemes.SolarizedDarkPatched          = add_scheme("Solarized Dark - Patched")
schemes.SolarizedDarkHighContrast     = add_scheme("Solarized Dark Higher Contrast")
schemes.SolarizedDarkHighContrastGogh = add_scheme("Solarized Dark Higher Contrast (Gogh)")

local desired_scheme                  = schemes.SolarizedDarkHighContrastGogh
local builtin_schemes                 = wezterm.get_builtin_color_schemes()
local try_scheme                      = builtin_schemes[desired_scheme.name]
if try_scheme then
  scheme = try_scheme
else
  print("Invalid color scheme: " .. desired_scheme)
end

config.window_frame = {
  font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Bold' },
  font_size = 9,
}

config.window_background_opacity = 1.0
config.text_background_opacity = 0.30

config.colors = {
  foreground = scheme.ansi[8],
  background = scheme.background,
}

config.font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Regular' }
config.font_size = 7.5 -- IO/ANSI screen size is 80x24. 7.5 for my screen is 48 lines vim

config.check_for_updates = true
config.show_update_window = true
config.use_ime = true

config.hide_tab_bar_if_only_one_tab = false
config.adjust_window_size_when_changing_font_size = false
config.selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%"
config.window_padding = { bottom = 0, }
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.window_close_confirmation = "AlwaysPrompt"
config.skip_close_confirmation_for_processes_named = {
  -- 'bash', 'sh', 'zsh', 'fish',
  'tmux', 'nu',
  'cmd.exe', 'pwsh.exe', 'powershell.exe',
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = "https://github.com/$1/$3",
})

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
  local cells = {}
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local cwd = ''
    local hostname = ''

    if type(cwd_uri) == 'userdata' then
      cwd = cwd_uri.file_path -- check new URL object here, making this simple!
      hostname = cwd_uri.host or wezterm.hostname()
    else
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

    local dot = hostname:find '[.]' -- Remove the domain name portion of the hostname
    if dot then hostname = hostname:sub(1, dot - 1) end
    if hostname == '' then hostname = wezterm.hostname() end
    table.insert(cells, cwd)
    table.insert(cells, hostname)
  end

  local date = wezterm.strftime '%a %b %-d %H:%M' -- date/time:"Wed Mar 3 08:14"
  table.insert(cells, date)

  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  local LEFT_ARROW = utf8.char(0xe0b3)       -- The powerline < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2) -- The filled in variant of the < symbol

  local bg = scheme.background               -- Default: { '#3c1361', '#52307c', '#663a82', '#7c5295', '#b491c8', }
  local colors = { bg, bg, bg, bg, bg }      -- Color palette for the backgrounds of each cell
  local text_fg = scheme.ansi[8]             -- Foreground color for the text across the fade
  local elements = {}                        -- The elements to be formatted
  local num_cells = 0                        -- How many cells have been formatted

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

return config -- and finally, return the configuration to wezterm

-- References:
-- [Awesome dotfile](https://github.com/yutkat/dotfiles/blob/main/.config/wezterm/wezterm.lua)
