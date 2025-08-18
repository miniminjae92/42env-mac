# LTS Ubuntu
FROM ubuntu:22.04

# Non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages + sudo
RUN apt-get update && apt-get install -y \
    build-essential git curl wget unzip make \
    zsh gdb valgrind sudo tmux \
    libbsd-dev libx11-dev libxext-dev libssl-dev \
    python3-pip xclip bat fonts-powerline locales clangd fd-find ripgrep && \
    # Install Node.js 20 LTS and npm
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    # Install Gemini CLI
    npm install -g @google/gemini-cli && \
    # Install eza
    mkdir -p /etc/apt/keyrings && \
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list && \
    chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list && \
    apt-get update && apt-get install -y eza && \
    # Install delta
    curl -LO https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_arm64.deb && \
    dpkg -i git-delta_0.17.0_arm64.deb && \
    rm git-delta_0.17.0_arm64.deb && \
    # Create symlink for fd
    ln -s /usr/bin/fdfind /usr/bin/fd && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a user
ARG USERNAME=minjkang
RUN getent group staff || groupadd -g 20 staff && \
    useradd -m -s /bin/zsh -u 501 -g 20 $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

# Neovim ARM64 Install (AppImage Extract to /opt)
USER root
RUN mkdir -p /opt/nvim && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage && \
    chmod u+x nvim-linux-arm64.appimage && \
    ./nvim-linux-arm64.appimage --appimage-extract && \
    mv squashfs-root/* /opt/nvim/ && \
    rm nvim-linux-arm64.appimage && rm -rf squashfs-root
ENV PATH="/opt/nvim/usr/bin:$PATH"
ENV PATH="/home/minjkang/.local/bin:$PATH"
USER $USERNAME

# Install Oh My Zsh + Plugins + Theme + tpm
RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && \
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --no-fish --no-bash --bin && \
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash && \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy user config files
# COPY ./.config ~/.config
# COPY ./.zshrc ~/.zshrc
# COPY ./.tmux.conf ~/.tmux.conf
COPY ./.vimrc .vimrc
COPY ./.p10k.zsh .p10k.zsh
COPY ./c_formatter_42 .local/bin/c_formatter_42

USER root
RUN chmod +x /home/minjkang/.local/bin/c_formatter_42
USER $USERNAME

RUN echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc

# Set default shell
CMD ["zsh"]
