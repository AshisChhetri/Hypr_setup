#!/bin/bash

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

# base needed packages
sudo pacman -Syu git base-devel

# hyprinitial packages
hypr_pkgs=(
	"hyprland"
	"hyprpaper"
	"kitty"
	"wofi"
)

# Extra apps
ext_pkg=(
	"visual-studio-code-bin"
	"firefox"
	)


# Empty Array
to_install=()


# base package install loop
for package in "${initial_pkg[@]}"
do
	if ! is_installed "$package"; then
		sudo pacman -Sy $package
	else
		echo "$package is already installed."
	fi
done

# yay
if ! is_installed yay; then
	cd /opt
	sudo git clone https://aur.archlinux.org/yay.git
	sudo chown -R vagrant:vagrant yay
	cd yay
	makepkg -si
else
	echo "yay is already installed.."
fi

# hyprinstall loop
for package in "${hypr_pkgs[@]}"
do
	if ! is_installed "$package"; then
		to_install+=("$package")
	else
		echo "$ packages is already installed."
	fi
done

# extra pkg install loop
for package in "${ext_pkg[@]}"
do
	if ! is_installed "$package"; then
		to_install+=("$package")
	else
		echo "$package is already installed."
	fi
done

echo "packes are: $to_install"

#install pkg using yay
if [ ${#to_install[@]} -ne 0 ]; then
	echo "Installing packages: ${to_install[*]}"
	yay -Sy --needed "${to_install[@]}"
else
	echo "All packages are already installed"
fi

#echo "All packages have been checked installed if necessary."

