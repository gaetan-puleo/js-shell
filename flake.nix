{
  description = "JS devshell";
  inputs.nixpkgs.url = "github:numtide/nixpkgs-unfree";

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in pkgs.mkShell {
        buildInputs = [
          # Shell
          pkgs.tmux
          pkgs.ngrok
          pkgs.fish

          # JS
          pkgs.bun
          pkgs.nodejs_20
          pkgs.yarn


          # TO DO add libuuid and test with
          pkgs.libuuid
        ];

        shellHook = ''
          # export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.libuuid ]}"
          exec tmux
        '';
      };
      src = [
        ./.
      ];
  };
}
