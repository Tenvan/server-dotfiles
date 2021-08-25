#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

sudo rm /var/lib/pacman/db.lck 2> /dev/null

###########################
# collect needed packages #
###########################

# system packages
inst arj
inst bashtop
inst bat
inst bpytop
inst clamav
inst cockpit
inst cockpit-machines
inst docker
inst docker-compose
inst exa
inst lsd
uninst find-the-command
inst glances
inst htop
inst iftop
inst iotop
inst iptraf-ng
inst lhasa
inst multitail
inst neofetch
inst openconnect
inst openssh
inst p7zip
inst packagekit
inst s-tui
inst time
inst unrar
inst usermin
inst webmin
inst tar
inst update-grub

# language files
inst man-pages-de
uninst aspell-de
uninst mythes-de

inst git
inst libsecret

# file manager
inst mc
inst ranger
inst ttf-devicons

# installation of important editors
inst micro


#####################
# collect rust apps #
#####################

inst bat
inst fd
inst procs
inst ripgrep
inst tokei
inst git-delta

###############################
# uninstall unneeded packages #
###############################
if [ $DEBUG = false ]; then
	eval "$PACKER -R --noconfirm $PAKAGE_UNINST"
fi

#################################
# install all (needed) packages #
#################################
if [ $DEBUG = false ]; then
	eval "$PACKER -S $PAKKU_ALL $PAKAGE_INST"
	errorCheck "install packages"
fi

## FINISHING #
if [ "$ERROR_PAKAGE_UNINST" = "" ]; then
	print 'No Errors on Uninstall'
else
	print "Errors in Uninstall: ${ERROR_PAKAGE_UNINST}"
fi
if [ "$ERROR_PAKAGE_INST" = "" ]; then
	print 'No Errors on Install'
else
	print "Errors on Install: ${ERROR_PAKAGE_INST}"
fi
