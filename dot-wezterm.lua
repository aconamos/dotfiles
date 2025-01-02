-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Alabaster'
config.colors = {
    -- These colors yoinked from Afterglow
    foreground = "#d0d0d0",
    background = 'black',
    cursor_bg = "#d0d0d0",
    cursor_border = "#d0d0d0",
    cursor_fg = "#151515",
    selection_bg = "#303030",
    selection_fg = "#d0d0d0",
}

-- Cursor change and font
config.default_cursor_style = 'BlinkingBar'
-- Change the animation settings (preferably to off) if you're on
-- a laptop!
config.animation_fps = 30
config.cursor_blink_rate = 400
config.font = wezterm.font 'Cascadia Code'

-- This enables WSL integration which makes directories smarter,
-- launches WSL without executing wsl.exe, and a couple other
-- things I don't much care to learn about
config.default_domain = 'WSL:Debian'

-- Frustratingly, INTEGRATED_BUTTONS seems to cause lots of
-- issues in properly rendering the buttons, the acrylic
-- effect, and the colors. I have taken the easy route and
-- just accepted a default titlebar, with another effect.
-- 
config.window_decorations = 'RESIZE'
config.window_frame = {
    -- Wezterm seems to dislike decimal opacity values
    -- in the titlebar :(
    inactive_titlebar_bg = 'rgba(0, 0, 0, 0.7)',
    active_titlebar_bg = 'rgba(0, 0, 0, 0.7)',
}
-- config.integrated_title_button_color = 'rgba(0 0 0 0)'

-- Super awesome acrylic effect that I just can't get enough of.
-- I would prefer the backdrop to be acrylic, but that makes
-- the titlebar ugly color-wise. This is a compromise.
config.window_background_opacity = 0.7
config.win32_system_backdrop = 'Acrylic'
config.hide_tab_bar_if_only_one_tab = true

-- I would enjoy having a scrollbar, but once more, wezterm 
-- seems to disagree with me. Any right padding will be consumed
-- by the scrollbar, and I can't change the scrollbar width.
-- config.enable_scroll_bar = true

-- Initial width, constant size, and no confirm close
config.initial_cols = 100
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'

-- Function modified, originally from Sathya Tadinada
local function center_window_once(window)
    wezterm.GLOBAL.windows_centered = wezterm.GLOBAL.windows_centered or {}
  
    local window_id = window:window_id() .. ""
    if wezterm.GLOBAL.windows_centered[window_id] then
      return
    end
  
    -- Change the width and height
    local screen = wezterm.gui.screens().active
    local ratio = 0.65
    local width = screen.width * ratio
    local height = screen.height * ratio 
  
    window:set_inner_size(width, height)
  
    -- Set the actual location of the window
    -- Ideally, you would use get_dimensions(), but this seems to return
    -- wrong dimensions. Oh well.
    local taskbar_height = 46
    local x = (screen.width * 0.5 - width * 0.5)
    -- Note: This `+ 1` might be wrong on your system.
    local y = (screen.height * 0.5 - height * 0.5) - taskbar_height + 1
  
    wezterm.GLOBAL.windows_centered[window_id] = true
  
    window:set_position(x, y)
end
  
wezterm.on("update-status", function(window)
    center_window_once(window)
end)

-- and finally (angrily), return the configuration to wezterm
return config
