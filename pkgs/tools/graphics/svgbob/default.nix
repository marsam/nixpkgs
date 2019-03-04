{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "svgbob";
  version = "unstable-2018-10-05";

  src = fetchFromGitHub {
    owner = "ivanceras";
    repo = "svgbob";
    rev = "43fb0364e989d0e9a7656b148c947d47cc769622";
    sha256 = "1imjj57dx1af3wrs214yzaa2qfk8ld00nj3nx4z450gw2xjjj1gw";
  };

  sourceRoot = "source/svgbob_cli";

  cargoSha256 = "1j2fnhvzzakm7kwm6rwxir9vrvxb0y67ri39vw1sjy58rdiymaxv";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Convert your ascii diagram scribbles into happy little SVG";
    homepage = https://github.com/ivanceras/svgbob;
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
