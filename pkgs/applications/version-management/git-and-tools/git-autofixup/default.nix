{ stdenv, fetchFromGitHub, git, perl }:

stdenv.mkDerivation rec {
  name = "git-autofixup-${version}";
  version = "0.002005";

  nativeBuildInputs = [ git perl ];

  installPhase = ''
    install -Dm755 git-autofixup $out/bin/git-autofixup
    mkdir -p $out/share/man/man1
    pod2man README.pod > $out/share/man/man1/git-autofixup.1
  '';

  src = fetchFromGitHub {
    owner = "torbiak";
    repo = "git-autofixup";
    rev = "v${version}";
    sha256 = "1gjnr6ivsavnxi7d709dbs80vb67nqvh9zd12ibl9jnjv8fl1700";
  };

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "Create fixup commits for topic branches";
    license = licenses.artistic2;
    platforms = platforms.unix;
    maintainers = [ maintainers.marsam ];
  };
}
