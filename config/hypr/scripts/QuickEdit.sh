#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

# configs="$HOME/.config/hypr/configs"
# UserConfigs="$HOME/.config/hypr/UserConfigs"

menu(){
    printf "1. VS HyprConf\n"
}

main() {
    choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
    case $choice in
        1) code $HOME/.config/hypr
            ;;
        # 3)
        #     kitty -e nano "$UserConfigs/ENVariables.conf"
        #     ;;
  
        *)
            ;;
    esac
}

main