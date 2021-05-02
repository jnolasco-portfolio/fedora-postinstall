#!/bin/bash

###
# Theming and GNOME Options
###


# Tilix Dark Theme
gsettings set com.gexperts.Tilix.Settings theme-variant 'dark'

#Gnome Shell Theming
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
#gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark-solid'

#Set SCP as Monospace (Code) Font

## Pop fonts
## 
## For fonts, install
## 
## sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'
## and then go into Gnome Tweaks and make the following changes in Fonts:
## 
## Interface Text: Fira Sans Book 10
## Document Text: Roboto Slab Regular 11
## Monospace Text: Fira Mono Regular 11
## Legacy Window Titles: Fira Sans SemiBold 10
## Hinting: Slight
## Antialiasing: Standard (greyscale)
## Scaling Factor: 1.00

gsettings set org.gnome.desktop.interface document-font-name 'Roboto Slab 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Mono 11'
gsettings set org.gnome.desktop.interface font-name 'Fira Sans Semi-Light 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Fira Sans Semi-Bold 11'



gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false


