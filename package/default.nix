{
  stdenv,
  autoPatchelfHook,
  libsForQt5,
  pkgs,
  src,
  pname,
  version
}:

stdenv.mkDerivation rec {
  inherit src pname version;

  nativeBuildInputs = [
    autoPatchelfHook
    libsForQt5.qt5.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    kdePackages.full.out
    libgcc
    libusb1
    bluez.out
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/
    cp $out/obdautodoctor $out/bin/obdautodoctor
  '';
}
