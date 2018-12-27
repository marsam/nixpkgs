{ stdenv, fetchFromGitHub, autoreconfHook, makeWrapper, curl }:

stdenv.mkDerivation rec {
  pname = "riscv-gnu-toolchain";
  version = "20180629";

  src = fetchFromGitHub {
    owner = "riscv";
    repo = "riscv-gnu-toolchain";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "00b0n8kfpwn6m77n7sz51mdsrm75bykipcfs7nw354gback06hjz";
  };

  # nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    curl
  ];

  meta = with stdenv.lib; {
    description = "GNU toolchain for RISC-V, including GCC";
    homepage = https://github.com/riscv/riscv-gnu-toolchain;
    maintainers = [ maintainers.marsam ];
  };
}
