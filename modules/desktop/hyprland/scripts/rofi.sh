#!/usr/bin/env bash

case $1 in
drun)
  rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
  r_override="entry{placeholder:'Search Applications...';}listview{lines:9;}"
  pkill rofi || rofi -show drun -theme-str "$r_override" -theme "$rofi_theme"
  ;;
window)
  rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
  r_override="entry{placeholder:'Search Windows...';}listview{lines:9;}"
  pkill rofi || rofi -show window -theme-str "$r_override" -theme "$rofi_theme"
  ;;
file)
  rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
  r_override="entry{placeholder:'Search Files...';}listview{lines:8;}"
  pkill rofi || rofi -show filebrowser -theme-str "$r_override" -theme "$rofi_theme"
  ;;
emoji)
  r_override="entry{placeholder:'Search Emojis...';}listview{lines:15;}"
  rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-4/style-4.rasi"
  pkill rofi || rofi -modi emoji -show emoji -theme "${rofi_theme}" -theme-str "$r_override"
  ;;
games)
  r_override="entry{placeholder:'Search Games...';}listview{lines:15;}"
  rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-1/style-5.rasi"
  pkill rofi || rofi -show games -modi games -theme "${rofi_theme}" -theme-str "$r_override"
  ;;
chrome)
  ## Start of Chrome profile launcher
  CHROME_VERSION=""
  if [ -z "$CHROME_VERSION" ]; then
    CHROME_VERSIONS=("chromium" "google-chrome" "google-chrome-beta" "google-chrome-unstable")
    for version in "${CHROME_VERSIONS[@]}"; do
      if [ -d "$HOME/.config/$version" ]; then
        CHROME_VERSION="$version"
        break
      fi
    done
  fi

  if [ -z "$CHROME_VERSION" ]; then
    echo "Unable to find Chrome version"
    exit 1
  fi

  CHROME_USER_DATA_DIR="$HOME/.config/$CHROME_VERSION"
  if [ ! -d "$CHROME_USER_DATA_DIR" ]; then
    echo "Unable to find Chrome user data dir"
    exit 1
  fi

  DATA=$(python3 << END
import json
with open("$CHROME_USER_DATA_DIR/Local State") as f:
    data = json.load(f)

for profile in data["profile"]["info_cache"]:
    print("%s_____%s" % (profile, data["profile"]["info_cache"][profile]["name"]))
END
  )

  declare -A profiles=()
  while read -r line
  do
    PROFILE="\${line%_____*}"
    NAME="\${line#*_____}"
    profiles["\$NAME"]="\$PROFILE"
  done <<< "\$DATA"

  if [ -z "\$@" ]; then
    for profile in "\${!profiles[@]}"; do
      echo \$profile
    done | rofi -dmenu -p "Choose Chrome Profile" | {
      read choice
      if [ -n "\$choice" ]; then
        \$CHROME_VERSION --profile-directory="\${profiles[\$choice]}" > /dev/null 2>&1 &
      fi
    }
  else
    NAME="\${@}"
    \$CHROME_VERSION --profile-directory="\${profiles[\$NAME]}" > /dev/null 2>&1 &
  fi
  ;;
help | --help)
  echo "Usage: launch.sh [ACTION]"
  echo "Launch various rofi modes with custom themes and settings."
  echo ""
  echo "Actions:"
  echo "  drun         Launch application search mode"
  echo "  window       Switch between open windows"
  echo "  file         Browse and search files"
  echo "  emoji        Search and insert emojis"
  echo "  games        Launch games menu"
  echo "  chrome       Launch Chrome with profile selection"
  echo "  help         Display this help message"
  echo "  --help       Same as 'help'"
  echo ""
  echo "If no action is specified, defaults to 'drun' mode."
  exit 0
  ;;
*)
  exec "$0" drun
  ;;
esac
