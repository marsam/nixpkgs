{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "tflint";
  version = "0.7.5";

  src = fetchFromGitHub {
    owner = "wata727";
    repo = pname;
    rev = "v${version}";
    sha256 = "12d238yiwcnjnf1jgzwzp1bibbyx1fbvlzxjnvk2g9w7gyg8739a";
  };

  goDeps = ./deps.nix;

  goPackagePath = "github.com/wata727/tflint";

  meta = with lib; {
    homepage = https://github.com/wata727/tflint;
    description = "Terraform linter for detecting errors that can not be detected by `terraform plan`";
    license = licenses.mit;
    maintainers = [ maintainers.marsam ];
  };
}
