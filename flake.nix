{
  description = "Lua CI environment for telescope-foldmarkers.nvim";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # You can run the CI tasks with `nix develop --command make lint`
        devShell = pkgs.mkShell {
          name = "lua-ci";

          buildInputs = with pkgs; [
            neovim
            vimPlugins.telescope-nvim
            luajitPackages.luacheck
            stylua
          ];
        };
      }
    );
}
