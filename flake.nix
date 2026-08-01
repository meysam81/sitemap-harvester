{
  # Pinned: newer unstable revs fail poetry's test suite on python 3.14.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/a799d3e3886da994fa307f817a6bc705ae538eeb";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ poetry python314 ];

        env.POETRY_VIRTUALENVS_IN_PROJECT = "true";

        shellHook = ''
          export PATH="${pkgs.python314}/bin:$PATH"
        '';
      };
    };
}
