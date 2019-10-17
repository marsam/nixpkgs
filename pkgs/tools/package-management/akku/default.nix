{ stdenv, fetchurl, chez, which }:

stdenv.mkDerivation rec {
  pname = "akku";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/weinholt/akku/releases/download/v${version}/akku-${version}.src.tar.xz";
    sha256 = "0zdzqj4sp2n4ila2781bi7izzjlwp7azjlfpjnaj3qfc36f19b1p";
  };

  # installFlags = [ "" ];

  PREFIX="${placeholder "out"}";

  nativeBuildInputs = [ which ];

  installPhase = ''
    # substituteInPlace install.sh --replace "set -eu" "set -xeu"
    ./install.sh
    # PREFIX=$TMPDIR ./install.sh
    # $TMPDIR/bin/akku
  '';

  buildInputs = [ chez ];

  meta = with stdenv.lib; {
    homepage = "https://akkuscm.org";
    description = "Language package manager for Scheme";
    platforms = platforms.all;
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.marsam ];
  };
}
