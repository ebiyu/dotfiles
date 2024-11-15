local wezterm = require("wezterm")


-- open screen text in nvim
-- cf. https://zenn.dev/yutakatay/articles/wezterm-intro
wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
    local scrollback = pane:get_lines_as_text()
    local name = os.tmpname()
    local f = io.open(name, "w+")
    f:write(scrollback)
    f:flush()
    f:close()
    window:perform_action(
        wezterm.action({
            SpawnCommandInNewTab = {
                args = { "nvim", name },
            }
        }),
        pane
    )
    wezterm.sleep_ms(1000)
    os.remove(name)
end)

-- cf. https://coralpink.github.io/commentary/wezterm/dpi-detection.html
wezterm.on('window-focus-changed', function(window, pane)
    local dpi = window:get_dimensions().dpi
    local overrides = window:get_config_overrides() or {}
    overrides.font_size = dpi >= 140 and 14.0 or nil
    window:set_config_overrides(overrides)
end)

local config = {
    leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 2000 },
    keys = require('keybinds').keys,
    key_tables = require('keybinds').key_tables,
    disable_default_key_bindings = true,
    font = require("wezterm").font("Firge35Nerd Console"),
    font_size = 11.0,
    color_scheme = "Arthur",
    use_ime = false,
}


if string.sub(wezterm.home_dir, 1, 2) == "C:" then
    config.default_prog = {"powershell.exe"}
end

local wsl_ip = io.popen("wsl bash -c 'echo -n `hostname -I`'"):read('*a')

config.ssh_domains = {
  {
    name = 'wsl',
    remote_address = wsl_ip,
    username = 'ebi',
  },
}

return config
