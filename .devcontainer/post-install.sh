#!/bin/bash
set -e

WORKSPACE_DIR=$(pwd)
WORKSPACE_FOLDER=${WORKSPACE_FOLDER:-$WORKSPACE_DIR}

export UV_PROJECT_ENVIRONMENT="${WORKSPACE_FOLDER}/.venv"
export UV_CACHE_DIR="${WORKSPACE_FOLDER}/.cache"


pushd "$WORKSPACE_FOLDER"
uv sync
popd

echo "Setup ZSH"
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -p https://github.com/unixorn/fzf-zsh-plugin \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p https://github.com/marlonrichert/zsh-autocomplete \
    -p https://github.com/zdharma-continuum/fast-syntax-highlighting \
    -t amuse

# inside ~/.oh-my-zsh/themes/amuse.zsh-theme, replace the line starting with PROMPT with custom prompt
sed -i 's/^PROMPT=.*/PROMPT="%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info) $ "/' ~/.oh-my-zsh/themes/amuse.zsh-theme
sed -i 's/^RPROMPT=.*/RPROMPT="⌚ %{$fg_bold[red]%}%*%{$reset_color%} $(ruby_prompt_info)"/' ~/.oh-my-zsh/themes/amuse.zsh-theme

echo "Done!"