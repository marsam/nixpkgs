{ stdenv, fetchurl, autoreconfHook, gettext, makeWrapper
, alsaLib, jack2Full, tk, fftw
, CoreServices, CoreAudio, AudioUnit, AudioToolbox
}:

stdenv.mkDerivation  rec {
  name = "puredata-${version}";
  version = "0.49-0";

  src = fetchurl {
    url = "http://msp.ucsd.edu/Software/pd-${version}.src.tar.gz";
    sha256 = "18rzqbpgnnvyslap7k0ly87aw1bbxkb0rk5agpr423ibs9slxq6j";
  };

  nativeBuildInputs = [ autoreconfHook gettext makeWrapper ];

  buildInputs = [ jack2Full fftw ]
    ++ stdenv.lib.optionals stdenv.isLinux [ alsaLib ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ CoreServices CoreAudio AudioUnit AudioToolbox ];

  configureFlags = [
    # "--enable-jack"
    "--enable-fftw"
    "--disable-portaudio"
    "--disable-oss"
  ] ++ stdenv.lib.optionals stdenv.isLinux [ "--enable-alsa" ];

  postInstall = ''
    wrapProgram $out/bin/pd --prefix PATH : ${tk}/bin
  '';

  meta = with stdenv.lib; {
    description = "A real-time graphical programming environment for audio, video, and graphical processing";
    homepage = http://puredata.info;
    license = licenses.bsd3;
    platforms = platforms.all;
    maintainers = [ maintainers.goibhniu ];
  };
}
