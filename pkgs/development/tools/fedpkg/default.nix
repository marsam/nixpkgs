{ stdenv, buildPythonApplication, buildPythonPackage, fetchurl, openidc-client, bugzilla, rpkg, six, mock, nose, freezegun }:

let
  fedora_cert = buildPythonPackage rec {
    name = "fedora-cert";
    version = "0.6.0.2";
    format = "other";

    src = fetchurl {
      url = "https://releases.pagure.org/fedora-packager/fedora-packager-${version}.tar.bz2";
      sha256 = "02f22072wx1zg3rhyfw6gbxryzcbh66s92nb98mb9kdhxixv6p0z";
    };
    propagatedBuildInputs = [ python_fedora pyopenssl ];
    doCheck = false;
  };
in buildPythonApplication rec {
  pname = "fedpkg";
  version = "1.35";

  src = fetchurl {
    url = "https://releases.pagure.org/fedpkg/${pname}-${version}.tar.bz2";
    sha256 = "1n8z97689x1rgq1bg81cjl6pyxanp3y689zgacz1whr92yda8jzl";
  };
  patches = [ ./fix-paths.patch ];
  propagatedBuildInputs = [ openidc-client bugzilla rpkg six ];

  checkInputs = [ mock nose freezegun ];
  checkPhase = ''
    nosetests
  '';

  meta = with stdenv.lib; {
    description = "Subclass of the rpkg project for dealing with rpm packaging";
    homepage = https://pagure.io/fedpkg;
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
  };
}
