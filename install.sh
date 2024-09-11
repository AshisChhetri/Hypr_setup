#!/bin/bash

# ------------ Custom Fun()----------------------------------
check_install_pkg(){
	if ! command -v "$1" &> /dev/null
	then
		echo "$1 is not installed. Installing...."
		sudo pacman -Sy "$1"
	else
		echo "$1 is already installed."
	fi
}

is_installed(){
	pacman -Qi "$1" &> /dev/null
	return $?
}
# --------------- End Of custom Function --------------------

#---------------- base package -------------------------------
# base needed packages
initial_pkg=(
	"git"
	"base-devel"
)

# base package install loop
for package in "${initial_pkg[@]}"
do
	if ! is_installed "$package"; then
		sudo pacman -Sy $package
	else
		echo "$package is already installed."
	fi
done

# -------------------- End Base Package------------------------ 

# yay
if ! is_installed yay; then
	cd /opt
	sudo git clone https://aur.archlinux.org/yay.git
	sudo chown -R $(whoami):$(whoami) yay
	cd yay
	makepkg -si
else
	echo "yay is already installed.."
fi

#sudo pacman -Syu git base-devel

#hyprinitial packages
hypr_pkgs=(
	"hyprland"
	"hyprpaper"
	"kitty"
	"curl"
	"cliphist"
	"grim"
	"gvfs"
	"gvfs-mtp"
	"imagemagick"
	"network-manager-applet"
	"brightnessctl"
	"pamixer"
	"pavucontrol"
	"polkit-gnome"
	"qt5ct"
	"qt6ct"
	"qt6-svg"
	"rofi-wayland"
	"slurp"
	"swaync"
	"swappy"
	"swww"
	"wofi"
	"wallust"
	"waybar"
	"wget"
	"wl-clipboard"
	"wlogout"
)

# Extra apps
ext_pkg=(
	"eog"
	"visual-studio-code-bin"
	"firefox"
	"thunar"
	"ranger"
  	"thunar-volman "
  	"tumbler"
  	"ffmpegthumbnailer"
  	"file-roller "
  	"thunar-archive-plugin"
	"nwg-look"
	)


# Empty Array
to_install=()


#-----------------------  new Code ----------------------

#----------------------- new code End -------------------



# hyprinstall loop
echo " hypr base packages..."
for package in "${hypr_pkgs[@]}"
do
	if ! is_installed "$package"; then
		to_install+=("$package")
	else
		echo "$package is already installed."
	fi
done

# extra pkg install loop
echo " extra packages..."
for package in "${ext_pkg[@]}"
do
	if ! is_installed "$package"; then
		to_install+=("$package")
	else
		echo " $package is already installed."
	fi
done

echo " packages are to install: $to_install"

#install to_install pkg using yay
if [ ${#to_install[@]} -ne 0 ]; then
	echo "Installing packages: ${to_install[*]}"
	yay -Sy --needed "${to_install[@]}"
else
	echo "All packages are already installed"
fi

# Font
yay --needed -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd noto-fonts-emoji


echo "All packages have been checked installed if necessary."

