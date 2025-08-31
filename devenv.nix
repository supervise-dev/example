{ pkgs, ... }:

{
  env = {
    PORT = "8080";
  };

  packages = with pkgs; [
    nodejs_20
    pnpm
    nodePackages.nodemon
  ];

  enterShell = ''
    echo "Node version: $(node --version)"
    echo "PNPM version: $(pnpm --version)"
  '';

  processes = {
      install-deps.exec = "pnpm install";
      devenv-watch.exec = "nodemon --watch . --ext js,ts,json --exec 'pnpm run dev'";
  };
}
