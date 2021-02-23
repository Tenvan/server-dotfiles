#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

#####################
# init distro check #
#####################

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "abort installation script 'install_all': $1"
        exit $retVal
    fi
}

sudo rm /var/lib/pacman/db.lck

sudo pacman -S --noconfirm --needed git base-devel colorgcc go ruby rust
errorCheck "installation base-devel"

git submodule update --init --recursive

# Config pacman
sudo pacman -S pamac-all
sed 's/^#Color$/Color/g' </etc/pacman.conf >pacman.conf
sudo mv pacman.conf /etc/
sed 's/^.*ILoveCandy$/ILoveCandy/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/
sed 's/^.*EnableAUR$/EnableAUR/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/
sed 's/^.*KeepBuiltPkgs$/KeepBuiltPkgs/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/

# install aur manager
pamac install --no-confirm pakku-git paru-git
errorCheck "installation aur manager"

# init mirror
paru -S $PAKKU_ALL --noconfirm pacman-mirrorup
pacman-mirrorup -v

# Prompt installieren
paru -S $PAKKU_ALL ttf-meslo-nerd-font-powerlevel10k zsh-theme-powerlevel10k starship-bin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

zinit creinstall zsh-users/zsh-completions

# disable sudo password
echo "Cmnd_Alias INSTALL = /usr/bin/pacman, /usr/share/pacman
Cmnd_Alias POWER = /usr/bin/pm-hibernate, /usr/bin/pm-powersave, /usr/bin/pm-suspend-hybrid, /usr/bin/pm-suspend
Defaults timestamp_timeout=300
$USER ALL=(ALL) NOPASSWD:INSTALL,POWER
$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/100-myrules

chmod -R -v +xrw ~/.scripts
errorCheck "set script flags"