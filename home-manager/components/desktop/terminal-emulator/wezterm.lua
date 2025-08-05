-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.exit_behavior = 'CloseOnCleanExit' -- if the shell program exited with a successful status
config.audible_bell = "Disabled"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.enable_scroll_bar = true

-- config.max_fps = 240
config.max_fps = 120
config.animation_fps = 60

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'
-- Transparancy
config.window_background_opacity = 0.9
config.text_background_opacity = 1.0 -- Keep text background solid
config.colors = {
    -- Overrides the cell background color when the current cell is occupied by the cursor and the cursor style is set to Block
    cursor_bg = '#ff00ff',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#000000',
};

config.font = wezterm.font_with_fallback {
    'Cozette',
    -- 'CozetteVector',
    'Fira Code',
}
-- Disable Bolding for Cozette Since I Don't Like It
config.font_rules = {
    {
        intensity = "Bold",
        font = wezterm.font("Cozette", { weight = "Medium", italic = false }),
    },
}
config.font_size = 10.0
config.line_height = 1.2
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- Disable font ligatures
config.adjust_window_size_when_changing_font_size = false   -- Disable font scaling
config.allow_square_glyphs_to_overflow_width = "Never"      -- Disable font scaling

-- Set default shell to fish for interactive sessions
config.default_prog = { 'fish' }

-- Tab bar configuration
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Window settings
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
 }

config.disable_default_key_bindings = true
config.keys = {
    -- Clipboard Copy
    { mods = 'SUPER',      key = 'c', action = wezterm.action.CopyTo("Clipboard"), },
    { mods = 'CTRL|SHIFT', key = 'c', action = wezterm.action.CopyTo("Clipboard"), },
    { mods = 'SUPER',      key = 'v', action = wezterm.action.PasteFrom("Clipboard"), },
    { mods = 'CTRL|SHIFT', key = 'v', action = wezterm.action.PasteFrom("Clipboard"), },
    
    -- Tab Navigation
    { mods = 'ALT',        key = '1', action = wezterm.action.ActivateTab(0), },
    { mods = 'ALT',        key = '2', action = wezterm.action.ActivateTab(1), },
    { mods = 'ALT',        key = '3', action = wezterm.action.ActivateTab(2), },
    { mods = 'ALT',        key = '4', action = wezterm.action.ActivateTab(3), },
    { mods = 'ALT',        key = '5', action = wezterm.action.ActivateTab(4), },
    { mods = 'ALT',        key = '6', action = wezterm.action.ActivateTab(5), },
    { mods = 'ALT',        key = '7', action = wezterm.action.ActivateTab(6), },
    { mods = 'ALT',        key = '8', action = wezterm.action.ActivateTab(7), },
    { mods = 'ALT',        key = '9', action = wezterm.action.ActivateTab(8), },
    { mods = 'ALT',        key = '0', action = wezterm.action.ActivateTab(-1), },
    { mods = 'ALT',        key = '[', action = wezterm.action.ActivateTabRelative(-1), },
    { mods = 'ALT',        key = ']', action = wezterm.action.ActivateTabRelative(1), },

    -- Tab Creation Deletion
    { mods = 'CTRL',       key = 'w', action = wezterm.action.CloseCurrentTab { confirm = true }, }, -- 
    { mods = 'CTRL',       key = 't', action = wezterm.action.SpawnTab("CurrentPaneDomain")}, -- 
    { mods = 'CTRL|SHIFT', key = 't', action = wezterm.action.SpawnTab("DefaultDomain")}, -- 
    
    { mods = 'CTRL',       key = 'r', action = wezterm.action.ReloadConfiguration}, -- 
    { mods = 'CTRL',       key = 'f', action = wezterm.action.Search{CaseSensitiveString=""}, }, -- 
    { mods = 'CTRL',       key = 'n', action = wezterm.action.SpawnWindow}, -- 
    { mods = 'CTRL',       key = '-', action = wezterm.action.IncreaseFontSize, },
    { mods = 'CTRL',       key = '=', action = wezterm.action.DecreaseFontSize, },
    { mods = 'CTRL',       key = '0', action = wezterm.action.ResetFontSize, },
}
 

return config
