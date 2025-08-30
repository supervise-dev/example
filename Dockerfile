FROM nixos/nix:latest

WORKDIR /app

# Enable flakes and configure Nix for faster builds
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
    echo "max-jobs = auto" >> /etc/nix/nix.conf

# Install devenv
RUN nix profile install --accept-flake-config nixpkgs#devenv

# Copy devenv config and build environment (cached layer)
COPY devenv.nix devenv.yaml* ./
RUN devenv shell -- echo 'Environment built' || true

# Copy package files and install deps
COPY package*.json pnpm-lock.yaml* ./
RUN devenv shell -- pnpm install

COPY . .

EXPOSE 3000

# Start with dev-watch directly
CMD ["devenv", "shell", "--", "nodemon", "--watch", ".", "--ext", "js,ts,json", "--exec", "pnpm run dev"]