{ stdenv, fetchurl, srcOnly, rustPlatform, fetchFromGitHub, llvmPackages, hwloc, cmake, python }:

let
  wasi-sdk = srcOnly {
    name = "wasi-sdk";
    src = fetchurl {
      url = "https://github.com/CraneStation/wasi-sdk/releases/download/wasi-sdk-5/wasi-sdk-5.0-linux.tar.gz";
      sha256 = "05mbd9c8ws1538v9k7rskiqx64vynzmjndh9hjvfgispgcbqlj45";
    };
  };
in rustPlatform.buildRustPackage rec {
  pname = "lucet";
  version = "unstable-2019-03-29";

  src = fetchFromGitHub {
    owner = "fastly";
    repo = "lucet";
    rev = "40ae1df64536250a2b6ab67e7f167d22f4aa7f94";
    sha256 = "17z1v0v163sfsh26p92kmv6zwrjm5ai919h2kg3yav0j1jgq9yn2";
    fetchSubmodules = true;
  };

  buildInputs = [ llvmPackages.libclang hwloc ];

  nativeBuildInputs = [ cmake python ];

  preBuild = ''
    export WASI_SDK="${wasi-sdk}/opt/wasi-sdk"
    export LIBCLANG_PATH="${llvmPackages.libclang}/lib"
  '';

  cargoSha256 = "0a41yf6yvb0d96kaqw79f9i7gc3bna51ml46cs4kq8f5zahccs9q";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Sandboxing WebAssembly Compiler";
    homepage = "https://github.com/fastly/lucet";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = [ maintainers.marsam ];
  };
}
