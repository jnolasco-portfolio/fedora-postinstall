#/bin/bash


cat <<EOF | sudo tee /etc/sysctl.d/98-nolasco.conf
vm.swappiness=1 
# Improve cache management
vm.vfs_cache_pressure=50
# For visual Studio Code
fs.inotify.max_user_watches=524288

EOF

###
# Install mis aplicaciones
###

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo

sudo dnf install -y \
dnf-plugins-core `#Provides the commands to manage your DNF repositories from the command line` \
java-1.8.0-openjdk.x86_64 `#OpenJDK 11` \
java-11-openjdk.x86_64 `#OpenJDK 11` \
vlc `#Best media player` \
code `#Visual Studio Code` \
skypeforlinux `#Skype for linux` \
google-roboto-fonts `#Roboto font` \
yaru-gtk?-theme `#Yaru gtk2 y gtk3 theme` \
adapta-gtk-theme `#Adapta GTK Theme` \
suru-icon-theme `#Suru icon theme` \
yaru-icon-theme `#Yaru icon theme` \
gnome-shell-theme-yaru `#gnome-shell-theme-yaru` \
geany \
geany-addons \
geany-plugins-autoclose \
geany-plugins-automark \
geany-plugins-codenav \
geany-plugins-commander \
geany-plugins-defineformat \
geany-plugins-geanyctags \
geany-plugins-geanydoc \
geany-plugins-geanyextrasel \
geany-plugins-geanygendoc \
geany-plugins-geanyinsertnum \
geany-plugins-geanymacro \
geany-plugins-geanyminiscript \
geany-plugins-geanynumberedbookmarks \
geany-plugins-geanypg \
geany-plugins-geanyprj \
geany-plugins-geniuspaste \
geany-plugins-git-changebar \
geany-plugins-keyrecord \
geany-plugins-lineoperations \
geany-plugins-lipsum \
geany-plugins-markdown \
geany-plugins-overview \
geany-plugins-pairtaghighlighter \
geany-plugins-pohelper \
geany-plugins-pretty-printer \
geany-plugins-projectorganizer \
geany-plugins-scope \
geany-plugins-sendmail \
geany-plugins-shiftcolumn \
geany-plugins-spellcheck \
geany-plugins-tableconvert  \
geany-plugins-treebrowser \
geany-plugins-updatechecker \
geany-plugins-vimode \
geany-plugins-workbench \
geany-plugins-xmlsnippets  
