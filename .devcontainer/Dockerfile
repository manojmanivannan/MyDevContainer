FROM mcr.microsoft.com/devcontainers/base:bullseye

ARG USERNAME=vscode

# Setup a persistent history file for zsh
RUN mkdir /commandhistory \
    && touch /commandhistory/.zsh_history \
    && chown -R $USERNAME /commandhistory
