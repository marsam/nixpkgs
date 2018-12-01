{ stdenv, fetchurl, python, buildPythonPackage, isPy3k, pyopenssl, dateutil, requests, requests-kerberos, six, rpm, mock }:

buildPythonPackage rec {
  pname = "koji";
  version = "1.16.1";
  format = "other"; # https://pagure.io/koji/issue/912

  # disabled = isPy3k;

  src = fetchurl {
    url = "https://releases.pagure.org/koji/${pname}-${version}.tar.bz2";
    sha256 = "01h84hpfax0hc26klza4xv2np7r4qc1588k1fpha10vy1m7q6775";
  };

  # `rpm-py-installer` tries to download and build `rpm`, but since we use our
  # `rpm` is not required anymore.
  # prePatch = ''
  #   substituteInPlace setup.py \
  #     --replace "'rpm-py-installer'," "# 'rpm-py-installer'," \
  #     --replace "requires.append('python-krbV')" "pass"
  # '';

  propagatedBuildInputs = [ pyopenssl dateutil requests requests-kerberos six rpm ];

  checkInputs = [ mock ];

  doCheck = false;

  makeFlags = "DESTDIR=$(out)";

  postInstall = ''
    mv $out/usr/* $out/
    cp -R $out/nix/store/*/* $out/
    mkdir -p $out/etc/systemd/system/
    mv $out/*.service $out/etc/systemd/system/
    rm -rf $out/nix $out/usr $out/sbin
  '';

  meta = {
    maintainers = [ ];
    platforms = stdenv.lib.platforms.linux;
  };
}
