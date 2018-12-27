{ stdenv, fetchFromGitHub, autoreconfHook, makeWrapper, flex, bison, curl, texinfo }:

stdenv.mkDerivation rec {
  pname = "riscv-gnu-toolchain";
  version = "20180629";

  src = fetchFromGitHub {
    owner = "riscv";
    repo = "riscv-gnu-toolchain";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "13hjmgdb9rx5icwc2ss0rxv41jj71x0if7mx3z5af3vdzgdkaj3i";
  };

  nativeBuildInputs = [ flex bison texinfo ];

  buildInputs = [
    curl                        # TODO(marsam): remove it
  ];

  meta = with stdenv.lib; {
    description = "GNU toolchain for RISC-V, including GCC";
    homepage = https://github.com/riscv/riscv-gnu-toolchain;
    maintainers = [ maintainers.marsam ];
  };
}
