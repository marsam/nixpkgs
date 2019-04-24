{ stdenv, buildPythonPackage, fetchPypi, isPy3k, urwid, pytest }:

buildPythonPackage rec {
  pname = "urwid_readline";
  version = "0.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a8b17c10d720313121f3b5358e648f5cdbe5754e61e6eadcedfe82d5973705e6";
  };

  disabled = !isPy3k;

  propagatedBuildInputs = [ urwid ];
  checkInputs = [ pytest ];

  meta = with stdenv.lib; {
    description = "readline text edit for urwid";
    homepage = https://github.com/rr-/urwid_readline;
    license = licenses.mit;
    maintainers = [ maintainers.marsam ];
  };
}
