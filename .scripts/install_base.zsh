#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "abort installation script 'install_base': $1"
        exit $retVal
    fi
}

inst() {
    PAKAGE_INST="${PAKAGE_INST} $1"
    
	eval "$PACKER -S $PACKER_ALL $1"
	
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "error on install: $1"
		ERROR_PAKAGE_INST="${ERROR_PAKAGE_INST} $1"        
    fi
}

uninst() {
    PAKAGE_UNINST="${PAKAGE_UNINST} $1"

    eval "$PACKER -R $PACKER_ALL $1"
    
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "error on uninstall: $1"
		ERROR_PAKAGE_UNINST="${ERROR_PAKAGE_UNINST} $1"        
    fi
}

sudo rm /var/lib/pacman/db.lck

###########################
# collect needed packages #
###########################

# system packages
inst arj
inst ark
inst bashtop
inst bat
inst bitwarden-cli-bin
inst bootsplash-systemd
inst bootsplash-theme-manjaro
inst bpytop
inst clamav
inst clamtk
inst cockpit
inst cockpit-machines
inst docker
inst docker-compose
inst exa
inst find-the-command
inst flatpak
inst glances
inst hardinfo
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
inst powershell-bin
inst python
inst python-psutil
inst python-pygit2
inst python-requests
inst python-taskw
inst python-xkbgroup
inst python2-distutils-extra
inst s-tui
inst shell-color-scripts
inst time
inst timeshift
inst unrar
inst usermin
inst webmin

# language files
inst man-pages-de
inst aspell-de
inst mythes-de

if [ $IS_GARUDA = true ]; then
	inst samba-support
fi

inst git
inst libsecret
inst mono

# file manager
inst mc
inst ranger

# installation of important editors
inst micro

inst ripgrep
inst tar

# grub
if [ $IS_GARUDA = true ]; then
	inst grub-theme-garuda
fi
if [ $IS_MANJARO != true ]; then
	inst grub2-theme-archlinux
	inst grub-theme-stylish-git
fi

## FINISHING #
if [ "$ERROR_PAKAGE_UNINST" -eq "" ]; then
	print 'No Errors on Uninstall'
else
	print "Errors in Uninstall: ${ERROR_PAKAGE_UNINST}"
fi
if [ "$ERROR_PAKAGE_INST" -eq "" ]; then
	print 'No Errors on Install'
else
	print "Errors on Install: ${ERROR_PAKAGE_INST}"
fi
