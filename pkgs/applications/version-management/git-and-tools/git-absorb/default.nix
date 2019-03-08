{ stdenv, fetchFromGitHub, rustPlatform, libiconv, Security }:

rustPlatform.buildRustPackage rec {
  name = "git-absorb-${version}";
  version = "2019-02-12";

  src = fetchFromGitHub {
    owner  = "tummychow";
    repo   = "git-absorb";
    rev    = "d39efe92e6e6166495973a2b63268b44be94c51c";
    sha256 = "0055ij1zvnxqq1dbcj6l4iabq7dfkmkvdcyc9qqxwcldsxj6mxx5";
  };

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ libiconv Security ];

  cargoSha256 = "0fvxs09b9x38vp0psvlvbj09myxrhabp95pp3nz7nxsgr7fxflrr";

  meta = with stdenv.lib; {
    description = "git commit --fixup, but automatic";
    homepage = https://github.com/tummychow/git-absorb;
    license = licenses.bsd3;
    maintainers = [ maintainers.marsam ];
  };
}
