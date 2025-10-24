{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    clang
    cmake
    sndio
    jack2
    zlib
    libedit
    pulseaudio
    alsa-lib
    openal
    SDL2
    pkg-config
    spirv-tools
    ffmpeg_6-full
    xorg.libX11
    xorg.libxcb
    xorg.libXext
    vulkan-validation-layers
    vulkan-utility-libraries
    kdePackages.full
    kdePackages.qtbase
    kdePackages.qttools
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    kdePackages.qtwayland
  ];
}
