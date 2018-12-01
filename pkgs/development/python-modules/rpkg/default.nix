{ stdenv, buildPythonPackage, isPy3k, fetchurl, six, pycurl, cccolutils
, koji, rpmfluff, toPythonModule }:

buildPythonPackage rec {
  pname = "rpkg";
  version = "1.56";
  disabled = isPy3k;

  src = fetchurl {
    url = "https://releases.pagure.org/rpkg/${pname}-${version}.tar.gz";
    sha256 = "0aav3fca05497jdksjgf5abiyjpabwdrk223391dxwfx4chgmqh3";
  };

  propagatedBuildInputs = [ pycurl koji cccolutils six rpmfluff ];

  doCheck = false; # needs /var/lib/rpm database to run tests

  meta = with stdenv.lib; {
    description = "Python library for dealing with rpm packaging";
    homepage = https://pagure.io/fedpkg;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ];
  };

}
