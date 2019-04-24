{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "urwid";
  version = "2.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1g6cpicybvbananpjikmjk8npmjk4xvak1wjzji62wc600wkwkb4";
  };

  meta = with stdenv.lib; {
    description = "A full-featured console (xterm et al.) user interface library";
    homepage = http://urwid.org/;
    license = licenses.lgpl21;
    maintainers = [ maintainers.marsam ];
  };
}
