{ stdenv, fetchFromGitHub, rustPlatform, CoreServices, Security, cf-private }:

rustPlatform.buildRustPackage rec {
  pname = "lorri";
  version = "unstable-2019-03-28";

  src = fetchFromGitHub {
    owner = "target";
    repo = pname;
    rev = "703c71b7d0c51cc26f9b42b71fca9a2335d45903";
    sha256 = "0qspj582yp89l78ijlbw75q0dgajsbhdb91yik0y6lq1gxnv1h3z";
  };

  BUILD_REV_COUNT = 1;

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ CoreServices Security cf-private /* for _CFURLResourceIsReachable */ ];

  cargoSha256 = "04v9k81rvnv3n3n5s1jwqxgq1sw83iim322ki28q1qp5m5z7canv";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Your project's nix-env";
    homepage = https://github.com/target/lorri;
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
