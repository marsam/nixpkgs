{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "sudo_pair";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "square";
    repo = "sudo_pair";
    rev = "sudo_pair-v${version}";
    sha256 = "149i8p0isw7dq22dal2r77mhgfbcwih3yik2l1jiiccvj39km08l";
  };

  cargoSha256 = "0qwbgwxrjc0dvjbpqa59jixy5nq7lng2c1z91rw48qc91v7fa660";

  buildInputs = [ ];

  meta = with stdenv.lib; {
    description = "Plugin for sudo that requires another human to approve and monitor privileged sudo sessions";
    homepage = https://github.com/square/sudo_pair;
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
