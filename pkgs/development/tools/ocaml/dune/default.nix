{ stdenv, fetchurl, ocamlPackages }:

stdenv.mkDerivation rec {
  pname = "dune";
  version = "1.6.2";

  src = fetchurl {
    url = "https://github.com/ocaml/dune/releases/download/${version}/dune-${version}.tbz";
    sha256 = "1k675mfywmsj4v4z2f5a4vqinl1jbzzb7v5k6rzyfgvxzd7gil40";
  };

  buildInputs = with ocamlPackages; [ ocaml findlib ];

  buildFlags = "release";

  dontAddPrefix = true;

  makeFlags = [ "PREFIX=$(out)" "LIBDIR=$(OCAMLFIND_DESTDIR)" ];

  meta = {
    homepage = https://dune.build/;
    description = "A composable build system for OCaml";
    maintainers = [ stdenv.lib.maintainers.vbgl ];
    license = stdenv.lib.licenses.mit;
    inherit (ocamlPackages.ocaml.meta) platforms;
  };
}
