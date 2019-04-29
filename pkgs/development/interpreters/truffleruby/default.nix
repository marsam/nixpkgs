{ stdenv, fetchFromGitHub, openjdk, ruby, openssl, graalvm8, jvmci8, mx }:

stdenv.mkDerivation rec {
  pname = "truffleruby";
  version = "vm-1.0.0-rc16";

  src = fetchFromGitHub {
    owner = "oracle";
    repo = "truffleruby";
    rev = version;
    sha256 = "11d2yx282r6ns53j3ak2nswfhqra70al9ylkil0kbgdv5g6bhdl7";
  };

  nativeBuildInputs = [ ruby mx ];
  buildInputs = [ openjdk openssl ];

  preConfigure = ''
    export OPENSSL_PREFIX="${openssl.dev}"
    export GRAAL_HOME="${graalvm8}"
    export JVMCI_HOME="${jvmci8}"
  '';

  # https://github.com/oracle/truffleruby/blob/master/doc/contributor/workflow.md
  buildPhase = ''
    tool/jt.rb build
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/oracle/truffleruby;
    description = "A high performance implementation of the Ruby programming language";
    license = [ licenses.epl10 /* or */ licenses.gpl2 /* or */ licenses.lgpl21 ];
    platforms = platforms.all;
    maintainers = [ maintainers.marsam ];
  };
}
