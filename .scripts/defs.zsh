#!/usr/bin/env zsh

#####################
# init distro check #
#####################
export LINUX_VERSION_NAME=$(lsb_release -si)
export IS_ARCH=false
export IS_ARCO=false
export IS_MANJARO=false
export IS_GARUDA=false
export SCRIPTS="$HOME/.scripts"
export PACKER=paru

#export DEBUG=true
export DEBUG=false

if [ $LINUX_VERSION_NAME = "Archlinux" ]; then
	export IS_ARCH=true
fi

if [ $LINUX_VERSION_NAME = "Arcolinux" ]; then
	export IS_ARCO=true
fi

if [ $LINUX_VERSION_NAME = "ManjaroLinux" ]; then
	export IS_MANJARO=true
fi

if [ $LINUX_VERSION_NAME = "Garuda" ]; then
	export IS_GARUDA=true
fi

print "Linux Version: $LINUX_VERSION_NAME"
print "IsArch:        $IS_ARCH"
print "IsArco:        $IS_ARCO"
print "IsGaruda:      $IS_GARUDA"
print "IsManjaro:     $IS_MANJARO"

export MAKEFLAGS="-j$(nproc)"
export PACKER_ALL="--quiet --color always --noconfirm "

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "abort installation script 'install_base': $1"
        exit $retVal
    fi
}

inst() {
    PAKAGE_INST="${PAKAGE_INST} $1"

    if [ $DEBUG = true ]; then
		eval "$PACKER -S $PACKER_ALL $1"
		
	    retVal=$?
	    if [ $retVal -ne 0 ]; then
	        print "error on install: $1"
			ERROR_PAKAGE_INST="${ERROR_PAKAGE_INST} $1"        
	    fi
	fi
}

inst_now() {
	eval "$PACKER -S $PACKER_ALL $1"
	errorCheck "Install $"
}

uninst() {
    PAKAGE_UNINST="${PAKAGE_UNINST} $1"

    if [ $DEBUG = true ]; then
	    eval "$PACKER -R $PACKER_ALL $1"
	    
	    retVal=$?
	    if [ $retVal -ne 0 ]; then
	        print "error on uninstall: $1"
			ERROR_PAKAGE_UNINST="${ERROR_PAKAGE_UNINST} $1"        
	    fi
    fi
}

uninst_now() {
	eval "$PACKER -R $PACKER_ALL $1"
	errorCheck "Install $"
}
