{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "guix";
  version = "1.0.1";

  src = fetchurl {
    url = "mirror://gnu/guix/guix-binary-${version}.${stdenv.targetPlatform.system}.tar.xz";
    sha256 = {
      "x86_64-linux" = "0fsq12cwgv8v77slprslwcmsyhdm9hr5dcadgwfmgawz4084c98b";
      "i686-linux" = "0iri5j26n3gjh8sih49maz7f67w993lfaqhvx6k6zwz8y3bg7xb1";
      "aarch64-linux" = "1pkyfky12a3pbghrhi5yr6bininxzkiqqfvsry44dgdwv0zgirxf";
    }."${stdenv.targetPlatform.system}";
  };

  sourceRoot = ".";

  outputs = [ "out" "store" "var" ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    # copy the /gnu/store content
    mkdir -p $store
    cp -r gnu $store

    # copy /var content
    mkdir -p $var
    cp -r var $var

    # link guix binaries
    mkdir -p $out/bin
    ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix $out/bin/guix
    ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix-daemon $out/bin/guix-daemon
  '';

  meta = with stdenv.lib; {
    description = "The GNU Guix package manager";
    homepage = "https://guix.gnu.org/";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.johnazoidberg ];
    platforms = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];
  };
}
