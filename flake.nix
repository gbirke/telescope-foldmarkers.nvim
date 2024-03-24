{
  description = "Lua CI environment for telescope-foldmarkers.nvim";

  outputs = { self, nixpkgs }:

    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {

      # You can run the CI tasks with `nix develop --command make lint`
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          name = "lua-ci";

          buildInputs = with pkgs; [
            neovim
            vimPlugins.telescope-nvim
            luajitPackages.luacheck
            stylua
          ];
        };
      });
      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixpkgs-fmt);
    };
}
