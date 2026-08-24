FROM docker.io/library/debian:latest

# Update and install the tools we need:
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    wget \
    git \
    sudo \
    gcc \
    make \
    build-essential \
    pkg-config \
    libssl-dev \
    libgit2-dev \
    lldb \
    libsqlite3-dev \
    openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Nix
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon && \
    /nix/var/nix/profiles/default/bin/nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs && \
    /nix/var/nix/profiles/default/bin/nix-channel --update && \
    /nix/var/nix/profiles/default/bin/nix-env -iA nixpkgs.nixfmt

# Install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    mkdir -p /etc/starship && \
    echo 'eval "$(starship init bash)"' >> /etc/bashrc
COPY ./res/starship.toml /etc/starship/
ENV STARSHIP_CONFIG=/etc/starship/starship.toml

# Copy container setup files
RUN mkdir -p /usr/local/container-setup
COPY ./res/* /usr/local/container-setup/
RUN chmod +x /usr/local/container-setup/devcontainer-setup

# Create devuser
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to devuser for remaining installations
USER $USERNAME
WORKDIR /home/$USERNAME

# Configure starship
RUN echo 'eval "$(starship init bash)"' >> .bashrc

# Final setup steps
WORKDIR /workspace
CMD ["/bin/bash"]