{ stdenv, fetchFromGitHub, rustPlatform, Security }:

rustPlatform.buildRustPackage rec {
  pname = "sear-unstable";
  version = "2019-12-05";

  src = fetchFromGitHub {
    owner = "iqlusioninc";
    repo = "sear";
    rev = "2e69e05aac477bd517b674a8e4e1eacf2afa3f29";
    sha256 = "0l9wgl24n84597p1wy00cj7mh9qw431prsk5b3svfpdihy7929dw";
  };

  cargoSha256 = "06n4caiih1bxs1adpy7pchqxhxk3ajhghkvck9cx19irwi640qv5";

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/iqlusioninc/sear";
    description = "Signed/Encrypted ARchive: always-encrypted tar-like archive tool with optional signature support";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
