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
    -p virtualenv \
    -p git \
    -t amuse

# replace amuse.zsh-theme with this content
cat << 'EOF' > ~/.oh-my-zsh/themes/amuse.zsh-theme
# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"


PROMPT='%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info) $ '

RPROMPT='⌚ %{$fg_bold[red]%}%*%{$reset_color%} $(ruby_prompt_info)'

VIRTUAL_ENV_DISABLE_PROMPT=0
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=" %{$fg[green]%}🐍 "
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
EOF

echo "Done!"