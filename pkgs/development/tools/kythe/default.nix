{ stdenv, binutils, fetchurl, ncurses5 }:

stdenv.mkDerivation rec {
  pname = "kythe";
  version = "0.0.30";

  src = fetchurl {
    url = "https://github.com/kythe/kythe/releases/download/v${version}/kythe-v${version}.tar.gz";
    sha256 = "12bwhqkxfbkh3mm4wfvqflwhmbzpmlhlfykdpy6h7p9ih9ky8w6r";
  };

  buildInputs = [ binutils ];

  doCheck = false;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/kythe
    cp -R * $out/share/kythe
    ln -s $out/share/kythe/tools $out/bin
  '';

  postFixup = ''
    for exe in $out/bin/*; do
      patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $exe
      patchelf --set-rpath "${stdenv.lib.makeLibraryPath [ stdenv.cc.cc.lib ncurses5 ]}" $exe
    done
  '';

  meta = with stdenv.lib; {
    description = "A pluggable, (mostly) language-agnostic ecosystem for building tools that work with code";
    longDescription = ''
      The Kythe project was founded to provide and support tools and standards
      that encourage interoperability among programs that manipulate source
      code. At a high level, the main goal of Kythe is to provide a standard,
      language-agnostic interchange mechanism, allowing tools that operate on
      source code — including build systems, compilers, interpreters, static
      analyses, editors, code-review applications, and more — to share
      information with each other smoothly.
    '';
    homepage = https://kythe.io/;
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = [ maintainers.mpickering ];
  };
}
