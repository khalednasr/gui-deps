# gui-deps
### List of library dependencies required to run some common cross-platform GUI frameworks on Linux.

While they run mostly out of the box on macOS or Windows, many cross-platform GUI frameworks such as PyQt/PySide, Dear ImGui, egui, or iced-rs require some additional dynamically-linked libraries to run on Linux. This flake maintains a simple list of these common libraries for use with the nix package manager in development or build environment.

## Usage
With
```nix 
gui-deps.url = "github:khalednasr/gui-deps";
```
added flake inputs you can use:
- ```inputs.gui-deps.from pkgs``` to get a list of the library packages.
- ```inputs.gui-deps.makeLibraryPathFrom pkgs``` to get a path pointing to the libraries.
- ```inputs.gui-deps.makeLibraryPathWith pkgs [ ... ]``` to get a path pointing to the libraries plus any additional packages needed.

### Example
To create a development shell with LD_LIBRARY_PATH set to the GUI library dependencies:
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    gui-deps.url = "github:khalednasr/gui-deps";
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        LD_LIBRARY_PATH = inputs.gui-deps.makeLibraryPathFrom pkgs;
      };
    };
}
```
