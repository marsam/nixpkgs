{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "sorbet-bin";
  version = "0.4.4595.20190807175359-647c1159f";

  src =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      fetchurl {
        url = "https://github.com/sorbet/sorbet/releases/download/${version}/linux.sorbet";
        sha256 = "07qn6scwqh585iih4cbk8lkdjyppc49xzac0zj75lnfmpxid23fx";
      }
    else if stdenv.hostPlatform.system == "x86_64-darwin" then
      fetchurl {
        url = "https://github.com/sorbet/sorbet/releases/download/${version}/mac.sorbet";
        sha256 = "046rx5vps7brmq0jv1y9p3giqxmgvbm74kb045d3p1frwca1knbg";
      }
    else throw "Architecture not supported";

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/sorbet

    runHook postInstall
  '';

  postFixup = stdenv.lib.optionalString stdenv.isLinux ''
    patchelf \
      --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      $out/bin/sorbet
  '';

  meta = with stdenv.lib; {
    description = "A Typechecker for Ruby";
    homepage = "https://sorbet.org/";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
