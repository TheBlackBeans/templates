{
  description = "A Rust project?";
  inputs = {
    naersk.url = github:nmattia/naersk/master;
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
    rustOverlay = github:oxalica/rust-overlay;
  };

  outputs = { self, naersk, nixpkgs, utils, rustOverlay }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk {};
      in {
        defaultPackage = naersk-lib.buildPackage ./.;
        defaultApp = utils.lib.mkApp {
          drv = self.defaultPackage.${system};
        };
        devShell = with pkgs; mkShell {
          buildInputs = [ cargo rustc rustfmt pre-commit rustPackages.clippy ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
        };
      });
}
