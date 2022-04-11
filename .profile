#!/usr/bin/env bash

export SCRIPTS="$HOME/.scripts"

# mods korrigieren
chmod +x $SCRIPTS/*

export CUSTOMS="$HOME/.custom"
export EDITOR=micro
export VISUAL="$EDITOR"
export FILEMANAGER="nemo"
export TIME="/usr/bin/time -v "
export TERM=xterm-256color

# Development profile
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Conditional PATH additions
for path_candidate in /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  /opt/local/sbin \
  /usr/local/bin \
  /usr/local/sbin \
  ~/.cabal/bin \
  ~/.cargo/bin \
  ~/.rbenv/bin \
  ~/.bin \
  ~/.scripts \
  ~/.local/bin \
  ~/.yarn/bin \
  ~/src/gocode/bin \
  ~/gocode \
  "$ANDROID_SDK_ROOT/platform-tools"
do
  if [[ -d "${path_candidate}" ]]; then
    export PATH="${PATH}:${path_candidate}"
  fi
done
