{ stdenv, rustPlatform, fetchFromGitHub /*Security*/ }:

rustPlatform.buildRustPackage rec {
  pname = "tikv";
  version = "3.0.7";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "1kh020x4kg5ynx34hmzql37x156j2qgv3hs5gpqywm1z1rrxvvdh";
  };

  cargoSha256 = "00cz6ig2002x6xpn41wfrfrp00x7cggjyyrlrqcz28aa99fd5hl0";

  meta = with stdenv.lib; {
    description = "Distributed transactional key-value database, originally created to complement TiDB";
    homepage = "https://tikv.org/";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
