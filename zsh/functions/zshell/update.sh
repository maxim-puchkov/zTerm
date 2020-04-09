#!/bin/sh

#  update.sh
#  devx
#
#  Created by admin on 2020-03-10.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


# Update Homebrew and formulae
function update.sh() {
    # Update package manager
    Info "Updating Homebrew"
    brew update
    # Upgrade formulae
    Info "Upgrading Homebrew formulae"
    brew upgrade
    # Display outdated and missing formulae
    brew outdated
    brew missing
    # Update tldr
    Info "Updating tldr"
    tldr --update
}
