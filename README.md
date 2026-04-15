# gui-deps
### List of library dependencies required to run some common cross-platform GUI frameworks on Linux.

Many common cross-platform GUI frameworks such as PyQt/PySide, Dear ImGui, egui, and iced-rs require some additional dynamically-linked libraries to run on linux. This flake maintains a list of these common libraries for use with the nix package manager in development or build environment.

## Usage
With
```nix 
gui-deps.url = "github:khalednasr/gui-deps";
```
added flake inputs you can use:
- ```inputs.gui-deps.from pkgs``` to get a list of the library packages
- ```inputs.gui-deps.makeLibraryPathFrom pkgs``` to get an LD_LIBRARY_PATH containing the packages
- ```inputs.gui-deps.makeLibraryPathWith pkgs [ ... ]``` to get an LD_LIBRARY_PATH containing the packages plus some additional packages

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
