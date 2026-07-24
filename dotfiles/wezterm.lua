local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.font = wezterm.font('HackGen Console NF')
config.font_size = 12.0
--config.color_scheme = 'Catppuccin Mocha'

config.unix_domains = {
    {
        name = 'unix',
    },
}

config.default_gui_startup_args = { 'connect', 'unix' }

config.keys = {
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
}

return config
