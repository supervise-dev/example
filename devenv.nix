{ pkgs, ... }:

{

  languages.typescript.enable = true;

  packages = with pkgs; [
    git
    nodejs_20
    pnpm
    nodePackages.nodemon
  ];

  env = {
    NODE_ENV = "development";
    PORT = "3000";
  };

  enterShell = ''
    echo "Node.js development environment ready!"
    echo "Node version: $(node --version)"
    echo "NPM version: $(npm --version)"
  '';

  scripts = {
    install.exec = "pnpm install && pnpm add @anthropic-ai/claude-code";
    dev.exec = "pnpm run dev";
    dev-watch.exec = "nodemon --watch . --ext js,ts,json --exec 'pnpm run dev'";
    build.exec = "pnpm run build";
    test.exec = "pnpm test";
    start.exec = "nodemon app.js";
  };
}
