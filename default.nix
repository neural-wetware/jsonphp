let
  pkgs = import <nixpkgs> {};

  jsonphp = { mkDerivation, base, stdenv }:
    with pkgs.haskellPackages;
    mkDerivation {
      pname = "jsonphp";
      version = "1.0";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [ base ];
      libraryHaskellDepends = [ aeson bytestring text unordered-containers scientific vector ];
      license = stdenv.lib.licenses.bsd3;
    };
in
  pkgs.haskellPackages.callPackage jsonphp {}
