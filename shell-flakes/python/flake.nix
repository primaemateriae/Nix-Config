{
  description = "Reproducible Python dev shell (uv + uv2nix) with bootstrap";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # A collection of Nix utilities to work with Python projects .
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # uv2nix: consume uv.lock/pyproject via Nix. Part of Pyproject.nix.
    # Produces a overlay that pins every dependency used in the venv. Then, Nix builds the environment. 
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Build backends (setuptools, hatchling, etc.) used when wheels aren't available Part of Pyproject.nix.
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Multi-System Boilerplate Utilities
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, uv2nix, pyproject-nix, pyproject-build-systems, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Singe source of truth for Python versioning.
        python = pkgs.python312; # <--------------------------------------------------------- Pick the Version of Python You want here.

        # Check for uv.lock inside the flake snapshot. Boot into bootstrap shell if none found.
        hasLock = builtins.pathExists "${self}/uv.lock";

        # native utilities packages
        native = with pkgs; [
          # pkg-config
          # gcc
          # openssl.dev
          # zlib
          # libffi
          # sqlite
          git
        ];

        # helper: env that forces uv to use Nix’s Python & never download its own
        uvEnv = {
          UV_PYTHON = "${python}/bin/python3"; # Follow the Python Pkg Above
          UV_PYTHON_PREFERENCE = "only-system"; # Prefer only system Python
          UV_PYTHON_DOWNLOADS = "never"; # Never fetch Python
        };
      in
      if !hasLock then {
        # Bootstrap Mode Shell (no uv.lock).

        # We need a uv.lock to work. If none is detected, a bootstrap mode shell is launched,
        # This temporary shell allows one to initialize the repo with uv.
        # This uses the uv downloaded and configured here, ensuring correct versioning and does not require a global downlaod of uv.
        devShells.default = pkgs.mkShell {
          packages = [ python pkgs.uv ] ++ native;
          env = uvEnv;
          shellHook = ''
            echo
            echo "[dev shell] 🛑 Bootstrap Mode (no uv.lock found)."
            echo "Using Python at: ${python}/bin/python3"
            echo
            echo "Run these once, then re-enter:"
            echo "  uv init --package . --python 3.12"
            echo "  uv add --dev ruff black mypy pytest ipython"
            echo "  uv lock"
            echo "  exit 
            echo "  nix develop .#full"
            echo
          '';
        };
      } else
        let
          # Locked Mode

          # Load uv workspace (reads pyproject.toml + uv.lock)
          workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };
          # Pins package versions exactly to uv.lock
          overlay = workspace.mkPyprojectOverlay {
            sourcePreference = "wheel"; # prefer wheels for speed. Use "sdist" for source build
          };

          # Compose a Python package set with pinned interpreter version. 
          pythonSet =
            (pkgs.callPackage pyproject-nix.build.packages { inherit python; }).overrideScope (pkgs.lib.composeManyExtensions [
              pyproject-build-systems.overlays.default
              overlay
            ]);

          # Build a virtual environment using Nix
          venv = pythonSet.mkVirtualEnv "py-env" workspace.deps.default; # runtime deps
          venvFull = pythonSet.mkVirtualEnv "py-env-full" workspace.deps.all; # runtime + dev/extras
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [ venv pkgs.uv ] ++ native;
            env = uvEnv // { UV_NO_SYNC = "1"; }; # don't let uv mutate Nix-built env
            shellHook = ''
              source ${venv}/bin/activate
              echo " Reproducible env (runtime). For dev deps: nix develop .#full"
            '';
          };

          devShells.full = pkgs.mkShell {
            packages = [ venvFull pkgs.uv ] ++ native;
            env = uvEnv // { UV_NO_SYNC = "1"; };
            shellHook = ''
              source ${venvFull}/bin/activate
              echo " Reproducible env (dev + extras)"
            '';
          };

          formatter = pkgs.nixpkgs-fmt;
        });
}
