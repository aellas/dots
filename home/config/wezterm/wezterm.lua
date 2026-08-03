local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28
config.font_size = 12
config.color_scheme = "tokyonight_night"
config.font = wezterm.font("IosevkaTerm Nerd Font")
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.colors = {
	background = "#13141c",
}

return config
