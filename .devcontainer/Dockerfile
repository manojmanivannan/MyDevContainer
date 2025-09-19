FROM mcr.microsoft.com/devcontainers/base:bullseye

ARG USERNAME=vscode

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo "$SNIPPET" >> "/home/$USERNAME/.zshrc" \
    && echo $SNIPPET >> /root/.zshrc

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -p fzf \
    -p https://github.com/zsh-users/zsh-autosuggestions.git \
    -p https://github.com/zsh-users/zsh-syntax-highlighting.git \
    -p https://github.com/marlonrichert/zsh-autocomplete.git \
    -p https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    -t agnoster