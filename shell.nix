let
  nixpkgs = builtins.fetchTarball {
    name = "nixos-25.11";
    url = "https://github.com/nixos/nixpkgs/archive/c8cfcd6ccd422e41cc631a0b73ed4d5a925c393d.tar.gz";
    sha256 = "sha256:1fdjh5jd5jx246fhfq13q5752nw9il5dwv36nqbcj4pa6kzwq9fy";
  };
  pkgs = import nixpkgs {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      meson
      clang
      ninja
    ];
  }
