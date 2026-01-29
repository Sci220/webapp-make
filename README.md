# webapp-make

Turn any website into a standalone desktop web app on Linux. Creates `.desktop` entries that open sites in their own browser window (app mode), complete with icons fetched from PWA manifests and favicons.

Includes both a CLI tool and a GTK4/Libadwaita GUI manager.

## Features

- **PWA manifest detection** - automatically fetches app name and high-quality icons from web app manifests
- **Multi-browser support** - Vivaldi, Brave, Chromium, Chrome, Firefox
- **Wayland-native** - passes `--ozone-platform=wayland` for Chromium-based browsers
- **Icon fetching** - tries manifest icons, favicon.ico, apple-touch-icon, Google S2, DuckDuckGo as fallbacks
- **Isolated profiles** - optionally run each web app with its own browser profile
- **Custom WM class** - set `StartupWMClass` for window manager rules
- **GUI manager** - GTK4/Libadwaita app to create, view, launch, and delete web apps

## Dependencies

### CLI (`webapp-make`)

- POSIX shell (`sh`)
- `curl` or `wget`
- `file` (for icon type detection)
- A supported browser (Vivaldi, Brave, Chromium, Chrome, or Firefox)
- Optional: `jq` (for better PWA manifest parsing)
- Optional: `wl-paste` (for clipboard URL detection)

### GUI (`webapp-make-gui`)

- Python 3
- GTK 4
- Libadwaita 1
- `webapp-make` CLI (must be in `$PATH`)

On Arch Linux:

```bash
sudo pacman -S gtk4 libadwaita python-gobject
```

## Installation

### Manual

```bash
# Copy scripts to a directory in your PATH
cp webapp-make webapp-make-gui ~/.local/bin/
chmod +x ~/.local/bin/webapp-make ~/.local/bin/webapp-make-gui
```

### From source

```bash
git clone https://github.com/Sci220/webapp-make.git
cd webapp-make
make install  # installs to ~/.local/bin by default
```

## Usage

### CLI

```bash
# Basic - auto-detects name and browser
webapp-make https://discord.com

# With custom name
webapp-make https://chat.openai.com --name "ChatGPT"

# Specify browser and isolate profile
webapp-make https://app.slack.com --browser brave --isolate

# Set custom WM class (useful for window manager rules)
webapp-make https://music.youtube.com --class youtube-music
```

If no URL is given, `webapp-make` tries to read from the Wayland clipboard (`wl-paste`), then prompts interactively.

### GUI

```bash
webapp-make-gui
```

The GUI lets you:
- Create new web apps with a form (URL, name, browser, isolated profile, WM class)
- View all existing web apps
- Launch web apps by clicking them
- Delete web apps with confirmation

## How it works

1. Fetches the target URL and checks for a PWA manifest (`manifest.json` / `site.webmanifest`)
2. Extracts the app name and best available icon from the manifest
3. Falls back to `favicon.ico`, `apple-touch-icon.png`, Google S2, or DuckDuckGo icons
4. Generates a `.desktop` file with the correct `Exec` line for app-mode browsing
5. Copies the desktop entry to `~/.local/share/applications/` and updates the desktop database

Created web apps appear in your application launcher and can be managed via the GUI or by editing/removing files in `~/.local/share/applications/` and `~/.local/share/webapps/`.

## File locations

| Path | Purpose |
|------|---------|
| `~/.local/share/applications/webapp-*.desktop` | Desktop entries |
| `~/.local/share/webapps/<slug>/icon.png` | Cached icons |
| `~/.local/share/webapps/<slug>/profile/` | Isolated browser profiles (if `--isolate` used) |
| `~/Desktop/webapp-*.desktop` | Desktop shortcuts |

## License

MIT
