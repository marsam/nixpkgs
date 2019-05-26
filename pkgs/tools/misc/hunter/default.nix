{ stdenv, fetchFromGitHub, rustPlatform, Security }:

rustPlatform.buildRustPackage rec {
  pname = "hunter";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "rabite0";
    repo = pname;
    rev = "v${version}";
    sha256 = "01xr8l5jqxq1hfbmdrh82yjg1013aklr5a2fiidgycy3ysd9kzaj";
  };

  cargoSha256 = "0xnd3n26qlxgiccc7a98625hxn2d61gg03mksknmipiwd3qdjs4x";

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security ];

  # Fails on dependency `async_value v0.2.3` build

  meta = with stdenv.lib; {
    description = "ranger-like file browser written in rust";
    homepage = "https://github.com/rabite0/hunter";
    license = licenses.wtfpl;
    maintainers = [ maintainers.marsam ];
  };
}
