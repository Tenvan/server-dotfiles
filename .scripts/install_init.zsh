#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

#####################
# init distro check #
#####################

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "abort installation script 'install_init': $1"
        exit $retVal
    fi
}

sudo rm /var/lib/pacman/db.lck

git submodule update --init --recursive

# install paru
yay -Syy --noconfirm --needed paru-bin pamac-cli
errorCheck "installation aur manager"

# Config pacman
sed 's/^#Color$/Color/g' </etc/pacman.conf >pacman.conf
sudo mv pacman.conf /etc/
sed 's/^.*ILoveCandy$/ILoveCandy/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/
sed 's/^.*EnableAUR$/EnableAUR/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/
sed 's/^.*KeepBuiltPkgs$/KeepBuiltPkgs/g' </etc/pamac.conf >pamac.conf
sudo mv pamac.conf /etc/
errorCheck "pamac config"

eval "$PACKER -S $PACKER_ALL git base-devel colorgcc go ruby rust"
errorCheck "installation base-devel"

# Prompt installieren
eval "$PACKER -S $PACKER_ALL ttf-meslo-nerd-font-powerlevel10k zsh-theme-powerlevel10k"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
errorCheck "installation prompt"

zinit creinstall zsh-users/zsh-completions
errorCheck "installation zsh-completions"

# disable sudo password
echo "Cmnd_Alias INSTALL = /usr/bin/pacman, /usr/share/pacman
Cmnd_Alias POWER = /usr/bin/pm-hibernate, /usr/bin/pm-powersave, /usr/bin/pm-suspend-hybrid, /usr/bin/pm-suspend
Defaults timestamp_timeout=300
$USER ALL=(ALL) NOPASSWD:INSTALL,POWER
$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/100-myrules

chmod -R -v +xrw ~/.scripts
errorCheck "set script flags"
