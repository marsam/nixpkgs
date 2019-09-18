{ lib, buildGoModule, fetchFromGitHub, go-bindata, go-bindata-assetfs }:

buildGoModule rec {
  pname = "documize-community";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "documize";
    repo = "community";
    rev = "v${version}";
    sha256 = "1qkc82bvpmgcil88630pnp1irc2w8rzlh702vl0v67vfmawpxpjq";
  };

  goPackagePath = "github.com/documize/community";

  buildInputs = [ go-bindata-assetfs go-bindata ];

  subPackages = ["edition"];

  modSha256 = "sha256:0s5p37lrlmkm0813gsmvngxiq5hqwsqrihcyswq758rw3viqfawh";

  meta = with lib; {
    description = "Open source Confluence alternative for internal & external docs built with Golang + EmberJS";
    license = licenses.agpl3;
    maintainers = with maintainers; [ ma27 elseym ];
    homepage = https://www.documize.com/;
  };
}
