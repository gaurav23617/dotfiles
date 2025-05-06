# /etc/zshenv: DO NOT EDIT -- this file has been generated automatically.
# This file is read for all shells.

# Only execute this file once per shell.
if [ -n "${__ETC_ZSHENV_SOURCED-}" ]; then return; fi
__ETC_ZSHENV_SOURCED=1

if [ -z "${__NIXOS_SET_ENVIRONMENT_DONE-}" ]; then
    . /nix/store/zldazmj3lc8gr6dfjn8i328p7i582fnx-set-environment
fi

HELPDIR="/nix/store/k6n88x9z7cqd21j0rrjq44bm0ralf3yp-zsh-5.9/share/zsh/$ZSH_VERSION/help"

# Tell zsh how to find installed completions.
for p in ${(z)NIX_PROFILES}; do
    fpath=($p/share/zsh/site-functions $p/share/zsh/$ZSH_VERSION/functions $p/share/zsh/vendor-completions $fpath)
done

# Setup custom shell init stuff.




# Read system-wide modifications.
if test -f /etc/zshenv.local; then
    . /etc/zshenv.local
fi
