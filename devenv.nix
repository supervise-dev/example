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

  tasks = {
    "app:install" = {
        exec = "pnpm install";
        before = [ "devenv:processes:devenv-watch" ];
    };
  };

  processes = {
      devenv-watch.exec = "nodemon --watch . --ext js,ts,json --exec 'pnpm run dev'";
  };
}
