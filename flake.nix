{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    devdrop = {
      url = "https://cdn2.obdautodoctor.com/release/obd-auto-doctor_5.1.4_amd64.tar.gz";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system: {
      name = system;
      value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {
        obdautodoctor = pkgs.callPackage (import ./package/default.nix) { src = inputs.devdrop; pname = "obdautodoctor"; version = "1.0"; };
        default = obdautodoctor;
      };
    })[ "x86_64-linux" ]);
  };
}
