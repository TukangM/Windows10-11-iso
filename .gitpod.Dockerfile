RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add - \
     && curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list \
     && sudo apt-get update -q \
     && sudo apt-get install -yq tailscale jq \
     && sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-nft
