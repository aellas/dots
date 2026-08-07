local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28
config.font_size = 12
config.font = wezterm.font("IosevkaTerm Nerd Font")
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true

local themes_dir = os.getenv("HOME") .. "/nux/home/config/themes"
local f = io.open(themes_dir .. "/.current", "r")
local current = "tokyonight"

if f then
	current = f:read("*l"):gsub("%s+", "")
	f:close()
end

local theme_file = themes_dir .. "/" .. current .. "/colours.lua"
local theme = { scheme = "tokyonight_night" } -- fallback

local chunk, load_err = loadfile(theme_file)
if chunk then
	local ok, result = pcall(chunk)
	if ok and type(result) == "table" then
		theme = result
	end
end

config.color_scheme = theme.scheme
if theme.colors then
	config.colors = theme.colors
end
return config
