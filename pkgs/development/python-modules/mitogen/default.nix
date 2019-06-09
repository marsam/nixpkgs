{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "mitogen";
  version = "0.2.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "76cb9afef92596818a4639afb2a0bb0384ce7b6699b353af55662057b08b1e57";
  };

  # too complicated to setup
  doCheck = false;

  meta = with lib; {
    description = "Library for writing distributed self-replicating programs";
    homepage = "https://mitogen.networkgenomics.com/";
    license = licenses.bsd3;
    maintainers = [ maintainers.marsam ];
  };
}
