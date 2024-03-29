#!/bin/bash

set -e

# Setup scripts and determine base directory
if [[ $0 == "bash" ]] ; then
  if [[ -e ~/.dotfiles ]] ; then
    cd ~/.dotfiles
    git pull --quiet
  else
    git clone --quiet https://github.com/daradermody/dotfiles.git ~/.dotfiles
  fi
  BASE=~/.dotfiles
else
  BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
fi

# Setup rc files
BACKUPS_DIR="${BASE}/backups/$(date +'%Y-%m-%d')"
mkdir -p "${BACKUPS_DIR}"
for file in $(ls -Ah "${BASE}/rc-files/") ; do
  if [[ -e "${HOME}/${file}" && ! -L "${HOME}/${file}" ]]; then
    cp "${HOME}/${file}" "${BACKUPS_DIR}"
  fi
  ln -srf "${BASE}/rc-files/${file}" "${HOME}/${file}"
done

# Add sourcing line to .bashrc
if ! grep "# Source version-controlled files" ~/.bashrc > /dev/null ; then
  echo "# Source version-controlled files" >> ~/.bashrc
  echo -e "for file in \$(find ${BASE}/sourceable/*) ; do source \${file}; done\n" >> ~/.bashrc
fi

echo "Installed dotfiles!"

