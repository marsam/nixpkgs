{ stdenv
, buildPythonApplication
, fetchFromGitHub
, fetchpatch
, urwid_2
, pyperclip
, requests
, slackclient
, urwid_readline
, pytest
}:

buildPythonApplication rec {
  pname = "sclack";
  version = "unstable-2019-03-13";

  # src = /Users/marsam/src/sclack;
  # src = fetchFromGitHub {
  #   owner = "SteveMcGrath";  # haskellcamargo
  #   repo = pname;
  #   rev = "5e2d2f458932fae383b43b21b62926c9d713c860";
  #   sha256 = "1ssjxhqs9ar8y45agmz4fdfbhi9q64maq4zb0i9vaajnkzabxjdh";
  # };

  # asyncio is only relevant for python3.3
  postPatch = ''
    substituteInPlace setup.py \
      --replace "'asyncio'," ""
    '';

  # doCheck = false;
  # We can't apply https://github.com/haskellcamargo/sclack/pull/115/ because includes fetchpatch ignores file renames See: https://github.com/NixOS/nixpkgs/issues/32084
  # patches = [
  #   # Fix pypi packaging, remove after https://github.com/haskellcamargo/sclack/pull/115/ gets merged
  #   (fetchpatch {
  #     url = "https://github.com/haskellcamargo/sclack/commit/5e2d2f458932fae383b43b21b62926c9d713c860.patch";
  #     sha256 = "07ff86q9ybya9j5gyc01qpn8wp562pk0s4p3jpqh7nf5p23kqvyk";
  #   })
  # ];

  propagatedBuildInputs = [ urwid_2 pyperclip requests slackclient (urwid_readline.override { urwid=urwid_2;}) ];

  checkInputs = [ pytest ];

  # test_api.py requires network access
  checkPhase = ''
    pytest --ignore tests/test_api.py
  '';

  meta = with stdenv.lib; {
    description = "The best CLI client for Slack, because everything is terrible";
    homepage = https://github.com/haskellcamargo/sclack;
    license = licenses.gpl3;
    maintainers = [ maintainers.marsam ];
  };
}
