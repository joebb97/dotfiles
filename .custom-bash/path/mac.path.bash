#!/bin/bash
if [[ $(uname) == "Darwin" ]]; then
    # SOURCE THINGS AND ADD TO PATH
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
        # shellcheck source=/dev/null
        source "$(brew --prefix)"/etc/bash_completion
    fi
fi
