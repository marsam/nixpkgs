{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "spotifyd-${version}";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner  = "Spotifyd";
    repo   = "spotifyd";
    rev    = "refs/tags/v${version}";
    sha256 = "16r6clvbzcsk45zsycwfv3ixnlajndhzb1ibyi0gba09f0xn3yi6";
  };

  cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "A spotify daemon";
    license = license.gpl3;
    maintainers = [ maintainers.marsam ];
  };
}
