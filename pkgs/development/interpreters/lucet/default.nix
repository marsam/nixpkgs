{ stdenv, fetchurl, srcOnly, rustPlatform, fetchFromGitHub, llvmPackages, hwloc, cmake, python }:

let
  wasi-sdk = srcOnly {
    name = "wasi-sdk";
    src = fetchurl {
      url = "https://github.com/CraneStation/wasi-sdk/releases/download/wasi-sdk-3/wasi-sdk-3.0-linux.tar.gz";
      sha256 = "07wzy1gz56jgchrnv8pcc5hskjxc6cs8c7mfjglnysrr1rayanck";
    };
  };
in rustPlatform.buildRustPackage rec {
  pname = "lucet";
  version = "unstable-2019-03-29";

  src = fetchFromGitHub {
    owner = "fastly";
    repo = "lucet";
    rev = "28208e33ceb5b1e481973331731870c08b5eb038";
    sha256 = "0hq43pcv4g49h2y9np3pcsqf4mw2pc3cgnxzc4h3cg6ibac9gvkx";
    fetchSubmodules = true;
  };

  buildInputs = [ llvmPackages.libclang hwloc ];

  nativeBuildInputs = [ cmake python ];

  preBuild = ''
    export WASI_SDK="${wasi-sdk}/opt/wasi-sdk"
    export LIBCLANG_PATH="${llvmPackages.libclang}/lib"
  '';

  cargoSha256 = "0rhxn5xm77r29zp2s0q94hgb2619s8by433af5pw16zicq1mfb00";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Sandboxing WebAssembly Compiler";
    homepage = https://github.com/fastly/lucet;
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = [ maintainers.marsam ];
  };
}
