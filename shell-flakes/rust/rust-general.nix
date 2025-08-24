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
    # Oxalica's rust-overlay gives us prebuilt Rust toolchains.
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Multi-System Boilerplate Utilities
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, ... }:
    let
      # systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      # # Helper function to stich each `system` results into an attribute set.
      # forAllSystems = f:
      #   builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);

      # Default settings
      defaultMode = "inc"; # "cache" (sccache ON, incremental OFF) or "inc" (incremental ON, sccache OFF)
      defaultLinker = "mold"; # "mold" or "lld"
    in
    flake-utils.lib.eachDefaultSystem (system:
      {
        # devShells = forAllSystems (system:
        devShells = {
          let
          # Import nixpkgs for this system and apply the rust overlay.
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };

          lib = pkgs.lib;
          isLinux = pkgs.stdenv.isLinux;
          isDarwin = pkgs.stdenv.isDarwin;

          # Install Rust tools, which are pinned by Nix.
          # rustToolchain = pkgs.rust-bin.nightly.latest.default.override
          rustToolchain = pkgs.rust-bin.stable.latest.default.override
            {
              extensions = [ "rustfmt" "clippy" "rust-src" "llvm-tools-preview" ];
              # targets = [ "wasm32-unknown-unknown" ]; # Extra targets can be added here
            };

          compilerTools = with pkgs; [
            pkg-config # pkg-config helps native deps (OpenSSL, sqlite, etc.) find headers
            sccache # sccache caches compilation artifacts across builds
            clang # clang makes `-fuse-ld=…` flags behave consistently
            mold # Very fast linker (can be up to 5x faster than lld!) but with occasional instabilities. Around the speed of MacOS's ld-prime system linker.
            lld # LLD (LLVM Linker) tends to be faster than the default linker and quite stable. 
          ];

          devTools = with pkgs; [
            # Development Environment
            # rust-analyzer
            pkgs.rust-bin.stable.latest.rust-analyzer

            # Build Test
            bacon # Background rust compiler with nice TUI
            # cargo-nextest # Faster, better test runner

            # Security
            cargo-outdated # Check for outdated dependencies
            cargo-audit # Security vulnerability auditing
            cargo-deny # Supply chain security

            # Performance
            # cargo-flamegraph # A Rust-powered flamegraph generator with additional support for Cargo projects!
            # hyperfine # benchmarking tool.

            # Documentation 
            # mdbook
          ]
            # ++ lib.optionals isLinux [ pkgs.llvmPackages.libclang ] # uncomment if you use bindgen a lot)
          ;

          buildDependencies = [
            # sqlite
            # trunk
            # openssl
            # openssl.dev
            # zlib
          ];
          in
          {
          default = pkgs.mkShell {
            packages = [ rustToolchain ]
              ++ compilerTools
              ++ devTools
              ++ buildDependencies
            ;

            shellHook = ''
              echo "[dev shell] General Rust Toolchains with Fast Linking and Build Caching."

              # Linker Setting
              if [ "$(uname)" = "Linux" ]; then
                echo "[dev shell] Linux detected, using alternative linker;"
                LINKER="$RUST_LINKER"
                if [ -z "$LINKER" ]; then LINKER="${defaultLinker}"; fi
                export RUSTFLAGS="-C link-arg=-fuse-ld=$LINKER $RUSTFLAGS"
                echo "[dev shell] Linker: $LINKER"
              else
                echo "[dev shell] MacOS detected. Using system linker;"
                echo "[dev shell] Linker: ld64"
              fi


              # Build Setting
              MODE="$RUST_BUILD_MODE"
              if [ -z "$MODE" ]; then MODE="${defaultMode}"; fi
              if [ "$MODE" = "cache" ]; then
                export RUSTC_WRAPPER=sccache
                # sccache --start-server >/dev/null 2>&1 || true
                export CARGO_INCREMENTAL=0

                # Default sccache settings. 
                : "''${SCCACHE_DIR:=$HOME/.cache/sccache}"
                : "''${SCCACHE_CACHE_SIZE:=20G}"
                export SCCACHE_DIR SCCACHE_CACHE_SIZE

                if ! sccache --show-stats >/dev/null 2>&1; then
                  echo "[dev shell] Starting sccache server..."
                  sccache --start-server || echo "[dev shell] Warning: sccache server failed to start"
                fi

                echo "[dev shell] Build Mode: CACHE (sccache ON, incremental OFF)"
              else
                unset RUSTC_WRAPPER
                export CARGO_INCREMENTAL=1
                echo "[dev shell] Build Mode: INCREMENTAL (sccache OFF)"
              fi


              export RUST_BACKTRACE=1  # Usually helpful during development
              echo "[dev shell] rustc: $(rustc --version) | cargo: $(cargo --version)"
            '';
          };
        };
      }
    );
}
