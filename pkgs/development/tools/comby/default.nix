{ lib
, fetchFromGitHub
, ocamlPackages
}:

# https://github.com/comby-tools/comby/releases
ocamlPackages.buildDunePackage rec {
  pname = "comby";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "comby-tools";
    repo = pname;
    rev = version;
    sha256 = "02r4h94myv54savz0r8rsx2y76p2237ja7s4g1nryp7vg4mm7q2b";
  };

  buildInputs = with ocamlPackages; [
    core
    lwt4
    # mparser-comby # TODO
    ppxlib
    ppx_deriving
    angstrom
    # hack_parallel # TODO
    opium
    ocaml_pcre
    ocaml_oasis
    tls
    camlzip
    # patdiff # TODO
    lwt_react
    lambdaTerm
    ppx_deriving_yojson
    ppx_tools_versioned
    bisect_ppx
  ];

  meta = with lib; {
    homepage = "https://comby.dev/";
    description = "A tool for structural code search and replace that supports ~every language";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
