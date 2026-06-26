-- Workspacerules

-- Assign workspaces 1-6
for i = 1, 6 do
	local workspace = tostring(i)
	hl.workspace_rule({ workspace = workspace, monitor = "DP-1" })
end

hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true })

-- Windowrules

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Opacity by default
hl.window_rule({
	name = "opacity",
	match = {
		class = ".*",
	},
	opacity = "0.8 0.8",
})

-- No transparency windows
hl.window_rule({
	name = "no-transparency",
	match = {
		class = "^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$",
	},
	opacity = "1.0 1.0",
})

hl.window_rule({
	name = "no-yt-transparency",
	match = {
		class = ".*vivaldi.*",
		title = ".*[yY]ou[tT]ube.*",
	},
	opacity = "1.0 1.0",
})

hl.window_rule({
	name = "no-transparency-pip",
	match = {
		title = "^(Picture in picture)$",
	},
	opacity = "1.0 1.0",
})

-- Floating windows
hl.window_rule({
	name = "floating-big",
	match = {
		class = "^(floating-terminal|io.ente.auth|com.gabm.satty).*$",
	},
	float = true,
	center = true,
	size = { "1100", "700" },
})

hl.window_rule({
	name = "btop",
	match = {
		class = "btop",
	},
	float = true,
	center = true,
	size = { "1400", "800" },
})

hl.window_rule({
	name = "floating-small",
	match = {
		class = "^(floating-window|xdg-desktop-portal-gtk).*$",
	},
	tag = "+floating-window",
})

hl.window_rule({
	name = "floating-window",
	match = {
		tag = "floating-window",
	},
	float = true,
	center = true,
	size = { "800", "600" },
})

hl.window_rule({
	match = {
		class = "^(relaxou|TUI.float|org.pulseaudio.pavucontrol|nwg-look|blueman-manager|waypaper)$",
	},
	tag = "+floating-window",
})

hl.window_rule({
	name = "vivaldi-settings",
	match = {
		title = "^(Vivaldi Settings: General - Vivaldi).*$",
	},
	float = true,
	center = true,
	size = { "1000", "800" },
})

-- Picture in Picture
hl.window_rule({
	name = "picture-in-picture",
	float = true,
	pin = true,
	size = { "520", "320" },
	move = { "monitor_w*0.726", "monitor_h*0.697" },
	match = {
		title = "^(Picture in picture)$",
	},
})

-- Layer Rules

-- Blur for panels and popups
hl.layer_rule({
	name = "panel-blur",
	blur = true,
	ignore_alpha = 0.5,
	match = {
		namespace = "(waybar|swaync-control-center|swaync-notification-window)",
	},
})

-- Rofi
hl.layer_rule({
	name = "rofi",
	blur = true,
	ignore_alpha = 0.5,
	dim_around = true,
	match = {
		namespace = "rofi",
	},
})

-- Wlogout
hl.layer_rule({
	blur = true,
	match = {
		namespace = "logout_dialog",
	},
})
