{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "docker-slim";
  version = "1.26.1";

  goPackagePath = "github.com/docker-slim/docker-slim";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    # fetchzip yields a different hash on Darwin because `use-case-hack`
    sha256 =
      if stdenv.isDarwin
      then "0j72rn6qap78qparrnslxm3yv83mzy1yc7ha0crb4frwkzmspyvf"
      else "01bjb14z7yblm7qdqrx1j2pw5x5da7a6np4rkzay931gly739gbh";
  };

  subPackages = [ "cmd/docker-slim" "cmd/docker-slim-sensor" ];

  # docker-slim vendorized logrus files in different directories, which
  # conflicts on case-sensitive filesystems
  preBuild = stdenv.lib.optionalString stdenv.isLinux ''
    mv go/src/${goPackagePath}/vendor/github.com/Sirupsen/logrus/* go/src/${goPackagePath}/vendor/github.com/sirupsen/logrus/
  '';

  buildFlagsArray = [ "-ldflags=-s -w -X ${goPackagePath}/pkg/version.appVersionTag=${version} -X ${goPackagePath}/pkg/version.appVersionRev=${version}" ];

  meta = with stdenv.lib; {
    description = "Minify and secure Docker containers";
    homepage = "https://dockersl.im/";
    license = licenses.asl20;
    maintainers = with maintainers; [ filalex77 marsam ];
    # internal/app/sensor/monitors/ptrace/monitor.go:151:16: undefined: system.CallNumber
    # internal/app/sensor/monitors/ptrace/monitor.go:161:15: undefined: system.CallReturnValue
    badPlatforms = [ "aarch64-linux" ];
  };
}
