{
  description = "List of library dependencies required to run some common cross-platform GUI frameworks on Linux";

  outputs = inputs: rec {
    from =
      pkgs:
      with pkgs;
      lib.optionals stdenv.isLinux [
        dbus
        fontconfig
        freetype
        glib
        libGL
        libx11
        libxcb
        libxcb-cursor
        libxcb-image
        libxcb-keysyms
        libxcb-render-util
        libxcb-util
        libxcb-wm
        libxcursor
        libxext
        libxi
        libxkbcommon
        libxrandr
        stdenv.cc.cc
        wayland
        zlib
        zstd
      ];

    makeLibraryPathFrom = pkgs: "${pkgs.lib.makeLibraryPath (from pkgs)}:";

    makeLibraryPathWith =
      pkgs: additional: "${pkgs.lib.makeLibraryPath additional}:${makeLibraryPathFrom pkgs}:";
  };
}
