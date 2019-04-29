{ stdenv, fetchFromGitHub, pkgconfig, autoconf, automake, libtool, lv2, meson, ninja }:

stdenv.mkDerivation  rec {
  pname = "speech-denoiser";
  version = "unstable-07-10-2019";

  src = fetchFromGitHub {
    owner = "lucianodato";
    repo = pname;
    rev = "04cfba929630404f8d4f4ca5bac8d9b09a99152f";
    sha256 = "189l6lz8sz5vr6bjyzgcsrvksl1w6crqsg0q65r94b5yjsmjnpr4";
  };

  nativeBuildInputs = [ pkgconfig autoconf automake libtool meson ninja ];
  buildInputs = [ lv2 ];

  preConfigure =''
    cd rnnoise
    ./autogen.sh
    mv ../ltmain.sh ./ && ./autogen.sh #This is weird but otherwise it won't work (Related to bug #24 in rnnoise) 
    CFLAGS="-fvisibility=hidden -fPIC -Wl,--exclude-libs,ALL" \
    ./configure --disable-examples --disable-doc --disable-shared --enable-static
    make
    cd ..
  '';

  meta = with stdenv.lib; {
    description = "Speech denoise lv2 plugin based on RNNoise library";
    homepage = https://github.com/lucianodato/speech-denoiser;
    license = licenses.lgpl3;
    maintainers = [ maintainers.magnetophon ];
    platforms = platforms.linux;
  };
}
