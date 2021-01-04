#!/usr/bin/env bash

sh $SCRIPTS/defs.sh

#####################
# init distro check #
#####################
PKG_FILE=pkg_to_install.txt
PKG_UNINST_FILE=pkg_to_uninstall.txt

YAY_ALL="--needed --batchinstall --topdown --combinedupgrade \
    --nocleanmenu --devel --nodiffmenu --noeditmenu --noupgrademenu \
    --norebuild --noredownload --noprovides --pgpfetch \
    --useask --noremovemake"

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        echo "abort installation script 'install_all': $1"
        exit $retVal
    fi
}

inst() {
    echo $1 >>$PKG_FILE
}

uninst() {
    echo $1 >>$PKG_UNINST_FILE
}

rm -f $PKG_FILE
rm -f $PKG_UNINST_FILE

###########################
# collect needed packages #
###########################

###################
# system packages #
###################
inst exa
inst cronie
inst ripgrep
inst timeshift
inst alacritty
inst ark
inst arj
inst dpkg
inst lhasa
inst unrar
inst p7zip
inst neofetch
inst clamav
inst clamtk
inst glances
inst bashtop
inst bpytop
inst gtop
inst htop
inst iftop
inst iotop
inst iptraf-ng
inst s-tui
inst shell-color-scripts
inst powerline-rs
inst starship
inst find-the-command
inst hstr
inst qfc-git
inst kindd
inst multitail
inst openconnect

# gimicks
inst cmatrix
inst hollywood
inst cowsay

##########################
# Base Development Tools #
##########################
inst meld
inst git
inst gitflow-avh
inst github-cli
inst gitahead-bin
inst libsecret
inst nodejs-lts-fermium
inst nodejs-emojione
inst npm
inst yarn
inst dotnet-sdk
inst mono
inst mono-msbuild
inst jdk8-openjdk
inst openjdk8-src
inst jdk-openjdk

########################################
# Installing all used Window Managers  #
# Unter ArcoLinux TweakTool verwenden. #
########################################

# awesome packages
inst awesome
inst vicious
inst xorg-server-xephyr
inst luacheck
inst luarocks
inst lua-luajson
inst lua-socket
inst awmtt

#####################################
# installation desktop packages     #
# for tiling windows managers (all) #
#####################################
# system packages
inst appeditor-git
inst arandr
inst blueman
inst checkupdates-aur
inst copyq
inst genius
inst lxappearance
inst notify-send.sh
inst pm-utils
inst pygtk
inst python
inst python-psutil
inst python-pygit2
inst python-requests
inst python-taskw
inst python-xkbgroup
inst python2-distutils-extra
inst radiotray
inst rofi
inst seahorse
inst systemdgenie
inst time
inst xautolock
inst xbindkeys
inst xclip
inst xcwd-git
inst xdotool
inst xorg-xfd
inst xsel
inst zenity
inst skippy-xd-git

# utilities from gnome
inst gnome-disk-utility
inst gnome-system-monitor
inst gnome-system-log
inst gnome-keyring
inst gnome-calculator
inst gnome-menu-editor-qt

# polkits
inst polkit-gnome
#inst polkit-kde-agent

inst xscreensaver
inst qt-logout
inst clearine-git
inst qt5-styleplugins
inst qt5ct
inst phonon-qt5-gstreamer

# file manager
inst pcmanfm
inst mc
inst ranger

# sound setup
inst paprefs
inst pulseaudio-ctl
inst pulseaudio-qt
inst pulseaudio-equalizer-ladspa
inst pasystray

# printer setup
inst canon-cque
inst samsung-printers
inst cups-pdf
inst system-config-printer

# Office
inst libreoffice-fresh
inst libreoffice-fresh-de

# Browser
inst firefox-developer-edition
inst firefox-developer-edition-i18n-de
inst firefox
inst firefox-i18n-de
inst google-chrome
inst chromium
inst microsoft-edge-dev-bin
uninst vivaldi

# optional application packages
inst aspell
inst bitwarden-bin
inst bitwarden-cli-bin
inst bitwarden-rofi
inst docker
inst docker-compose
inst evolution
inst gimp
inst gimp-help-de
inst gparted
#inst grub-customizer
inst hardinfo
inst imagemagick
inst inkscape
inst ktorrent
inst nitrogen
inst partitionmanager
inst playerctl
inst pinta
inst pstoedit
inst python-lxml
inst python-numpy
inst qbittorrent
inst spectacle
inst teams
inst transfig
inst transmission-gtk
inst xfig
inst etcher-bin

# remmina
inst remmina
inst remmina-plugin-open
inst remmina-plugin-rdesktop
inst remmina-plugin-url
inst remmina-plugin-folder
inst remmina-plugin-open
inst freerdp

#inst picom-ibhagwan-git
inst picom-jonaburg-git

#####################################
# installation of important editors #
#####################################
# vs code
inst visual-studio-code-bin
inst bash-completion
inst lua-format

# neovim
inst neovim

# Atom
uninst atom-editor-bin
uninst atom-editor-git

# utils for editors
inst shellcheck
inst prettier
inst ripgrep
inst clang
inst tar
inst fd
inst gdb
inst graphviz
inst python-black
inst python-pyflakes
inst python-pipenv
inst python-nose
inst python-pytest

###############################################
# install wallpapers, themes, icons and fonts #
###############################################

# themes
inst arc-gtk-theme-colorpack
# inst arc-gtk-theme
inst arc-solid-gtk-theme
inst deepin-gtk-theme
inst materia-gtk-theme
inst kvantum-theme-materia
inst numix-gtk-theme
inst zuki-themes

#inst oomox
inst themix-full-git

# icons
inst arc-icon-theme
inst papirus-icon-theme
inst numix-icon-theme-pack-git

# inst bibata-extra-cursor-git
inst bibata-extra-cursor-theme
inst bibata-cursor-theme-bin
inst bibata-cursor-translucent

# wallpapers
inst ukui-wallpapers

# cursor
inst xcursor-breeze
inst xcursor-breeze-adapta
inst xcursor-breeze-serie-obsidian
inst xcursor-chameleon-anthracite
inst xcursor-chameleon-darkskyblue
inst xcursor-chameleon-pearl
inst xcursor-chameleon-skyblue
inst xcursor-chameleon-white

# icons
inst adwaita-icon-theme
# inst arc-icon-theme
inst paper-icon-theme
inst papirus-icon-theme
inst papirus-icon-theme
# inst sardi-icons

# fonts
inst font-manager
inst awesome-terminal-fonts

#inst nerd-fonts-complete
inst nerd-fonts-mononoki
inst nerd-fonts-iosevka

inst noto-fonts-emoji

inst ttf-twemoji
inst ttf-twemoji-color
inst ttf-weather-icons

###############################
# uninstall unneeded packages #
###############################
yay -R --noconfirm - <$PKG_UNINST_FILE

#################################
# install all (needed) packages #
#################################
yay -S $YAY_ALL - <$PKG_FILE
errorCheck "install packages"

## FINISHING #

# refresh icons
sudo gdk-pixbuf-query-loaders --update-cache

# Git config for meld
git config --global diff.tool code
git config --global difftool.code.cmd "$(which code) --wait --diff \"\$LOCAL\" \"\$BASE\" \"\$REMOTE\""
git config --global difftool.prompt false

git config --global merge.tool code
git config --global mergetool.code.cmd "$(which code) --wait \"\$MERGED\""
git config --global mergetool.prompt false

git config --global core.editor micro

git config --global user.name "stira"
git config --global user.email "ralf.stich@infoniqa.com"

sudo git config --system core.editor micro

git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple

git config pull.rebase false  # merge (the default strategy)
git config pull.ff only       # fast-forward only

git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

# nodejs tools for editors
sudo npm install -g neovim eslint jshint jsxhint stylelint sass-lint markdownlint-cli raml-cop typescript tern js-beautify iconv-lite
errorCheck "install required nodejs-tools"

# Default Browser setzen (vorher $BROWSER Variable entfernen)
xdg-settings set default-web-browser firefox-developer-edition.desktop

sudo fc-cache -fv
errorCheck "fontcache"

rm -f $PKG_FILE
rm -f $PKG_UNINST_FILE

sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
errorCheck "docker service"
