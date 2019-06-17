{ stdenv
, buildPythonPackage
, fetchPypi
, pytestrunner
, future
, requests
, requests_oauthlib
, pytest
}:

buildPythonPackage rec {
  pname = "python-twitter";
  version = "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "45855742f1095aa0c8c57b2983eee3b6b7f527462b50a2fa8437a8b398544d90";
  };

  nativeBuildInputs = [ pytestrunner ];
  propagatedBuildInputs = [ future requests requests_oauthlib ];
  checkInputs = [ pytest ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "A Python wrapper around the Twitter API";
    homepage = "https://github.com/bear/python-twitter";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
