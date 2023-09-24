{
  description = "JS devshell";
  inputs.nixpkgs.url = "github:numtide/nixpkgs-unfree";

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        FLAKE_PATH = "${self}";
      in pkgs.mkShell {
        buildInputs = [
          # Shell
          pkgs.tmux
          pkgs.ngrok

          # JS
          pkgs.bun
          pkgs.nodejs_20
          pkgs.yarn
        ];
        shellHook = ''
          echo "Entering shell"
          FLAKE_PATH=${FLAKE_PATH}
          alias nvim="nix run github:gaetan-puleo/nvim"
          alias tmux="tmux -f '${FLAKE_PATH}/config/tmux/tmux.conf'  -f '${FLAKE_PATH}/config/tmux/theme.conf'"
          export HOSTNAME=jsdevshell


          PS1="\[\033[01;32m\]\u@\$HOSTNAME\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\$ "

          exec tmux -f '${FLAKE_PATH}/config/tmux/tmux.conf'  -f '${FLAKE_PATH}/config/tmux/theme.conf'

        '';
      };
      src = [
        ./.
      ];
  };
}
