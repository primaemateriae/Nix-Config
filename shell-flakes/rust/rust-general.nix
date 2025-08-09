{
  description = "General-purpose Rust dev shell with fast linking and switchable cache/incremental modes";

  # Running Options
  #
  # Beyond the standard
  # `nix develop --command <shell>`
  # 
  # we can adjust the linker we want to use 
  # `RUST_LINKER=mold nix develop --command <shell>`
  # `RUST_LINKER=lld nix develop --command <shell>`
  #
  # and adjust the build strategy
  # `RUST_BUILD_MODE=inc nix develop --command <shell>`
  # `RUST_BUILD_MODE=cache nix develop --command <shell>`
  # If you are working on a single branch on a project whose dependencies remain somewhat the same, use incremental builds as sccache builds can be SLOWER.
  # If you are frequently swapping between branches with similar (but not identical) dependencies or expect to frequently delete Rust's cache, use sccache builds. Can also help with cold builds. 

  inputs = {
    # Unstable channel for freshest packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Oxalica’s rust-overlay gives us prebuilt Rust toolchains.
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];

      # Helper function to stich each `system` results into an attribute set.
      forAllSystems = f:
        builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);

      # Default settings
      defaultMode = "inc"; # "cache" (sccache ON, incremental OFF) or "inc" (incremental ON, sccache OFF)
      defaultLinker = "mold"; # "mold" or "lld"
    in
    {
      devShells = forAllSystems (system:
        let
          # Import nixpkgs for this system and apply the rust overlay.
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };

          # Install Rust tools, which are pinned by Nix.
          rustToolchain = pkgs.rust-bin.stable.latest.default.override
            {
              extensions = [
                "rustfmt"
                "clippy"
                "rust-src"
              ];
              # targets = [ "wasm32-unknown-unknown" ]; # Extra targets can be added here
            };

          speedTools = with pkgs; [
            sccache # sccache caches compilation artifacts across builds
            clang # clang makes `-fuse-ld=…` flags behave consistently
            mold # Very fast linker (can be up to 5x faster than lld!) but with occasional instabilities. Around the speed of MacOS's ld-prime system linker.
            lld # LLD (LLVM Linker) tends to be faster than the default linker and quite stable. 
            pkg-config # pkg-config helps native deps (OpenSSL, sqlite, etc.) find headers
          ];

          ra = pkgs.rust-analyzer;
        in
        {
          default = pkgs.mkShell {
            packages = [ rustToolchain ra ] ++ speedTools;

            shellHook = ''
              echo "[dev shell] General Rust Toolchains with Fast Linking and Build Caching."

              # Linker Setting
              LINKER="$RUST_LINKER"
              if [ -z "$LINKER" ]; then LINKER="${defaultLinker}"; fi
              export RUSTFLAGS="-C link-arg=-fuse-ld=$LINKER $RUSTFLAGS"
              echo "[dev shell] Linker: $LINKER"

              # Build Setting
              MODE="$RUST_BUILD_MODE"
              if [ -z "$MODE" ]; then MODE="${defaultMode}"; fi
              if [ "$MODE" = "cache" ]; then
                export RUSTC_WRAPPER=sccache
                sccache --start-server >/dev/null 2>&1 || true
                export CARGO_INCREMENTAL=0

                # Defaults for cache (override with env if you like)
                if [ -z "$SCCACHE_DIR" ]; then export SCCACHE_DIR="$HOME/.cache/sccache"; fi
                if [ -z "$SCCACHE_CACHE_SIZE" ]; then export SCCACHE_CACHE_SIZE="20G"; fi

                echo "[dev shell] Build Mode: CACHE (sccache ON, incremental OFF)"
              else
                unset RUSTC_WRAPPER
                export CARGO_INCREMENTAL=1
                echo "[dev shell] Build Mode: INCREMENTAL (sccache OFF)"
              fi
              echo "[dev shell] rustc: $(rustc --version) | cargo: $(cargo --version)"
            '';
          };
        });
    };
}
