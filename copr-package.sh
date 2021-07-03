#!/bin/bash

# Install Preload:
sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y

# Better Fonts:
sudo dnf copr enable dawid/better_fonts -y
sudo dnf install fontconfig-font-replacements -y
sudo dnf install fontconfig-enhanced-defaults -y