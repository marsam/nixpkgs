{ stdenv
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "memory-profiler";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "koute";
    repo = pname;
    rev = version;
    sha256 = "1j9fsbhcjhn2glpgqjd8m60xxbxn5wdvw8w35v5q63rrjkdxsy9j";
  };

  cargoSha256 = "051liwh09ip2ksk9wq3rx2v1hy22acf4m0k8hf5npxb3yjw5y9ww";

  meta = with stdenv.lib; {
    description = "A memory profiler for Linux";
    homepage = "https://github.com/koute/memory-profiler";
    license = [ licenses.mit /* or */ licenses.asl20 ];
    maintainers = [ maintainers.marsam ];
    platforms = platforms.linux;
  };
}
