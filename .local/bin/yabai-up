#!/bin/bash
# set codesigning certificate name here (default: yabai-cert)
export YABAI_CERT=

# stop yabai
yabai --stop-service

# reinstall yabai (remove old service file because homebrew changes binary path)
yabai --uninstall-service
brew reinstall koekeishiya/formulae/yabai
codesign -fs "${YABAI_CERT:-yabai-cert}" "$(brew --prefix yabai)/bin/yabai"

echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

# finally, start yabai
yabai --start-service
