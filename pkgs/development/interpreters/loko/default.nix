{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "loko";
  version = "0.3.2";
  # buildInputs = [ ];

  src = fetchurl {
    url = "https://scheme.fail/releases/loko-${version}.tar.gz";
    sha256 = "05jn9rkr3sa6sswk31bz4g9ki9ng3issa991w14yqda7hsndy3qd";
  };

  meta = with stdenv.lib; {
    homepage = "https://scheme.fail";
    description = "Optimizing R6RS compiler for Linux and bare hardware";
    platforms = platforms.all;
    license = licenses.agpl3Plus;
    maintainers = [ maintainers.marsam ];
  };
}
