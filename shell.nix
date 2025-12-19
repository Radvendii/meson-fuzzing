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
      (meson.overrideAttrs (old: {
        patches = (old.patches or []) ++ [(
          pkgs.writeText "dont-check-sanitizers.patch" ''
            diff --git i/mesonbuild/compilers/compilers.py w/mesonbuild/compilers/compilers.py
            index a823aeb00..7209e853a 100644
            --- i/mesonbuild/compilers/compilers.py
            +++ w/mesonbuild/compilers/compilers.py
            @@ -362,11 +362,7 @@ def get_base_link_args(target: 'BuildTarget',
                     if sanitizer == ['none']:
                         sanitizer = []
                     sanitizer_args = linker.sanitizer_link_args(sanitizer)
            -        # We consider that if there are no sanitizer arguments returned, then
            -        # the language doesn't support them.
                     if sanitizer_args:
            -            if not linker.has_multi_link_arguments(sanitizer_args, env)[0]:
            -                raise MesonException(f'Linker {linker.name_string()} does not support sanitizer arguments {sanitizer_args}')
                         args.extend(sanitizer_args)
                 except KeyError:
                     pass
          ''
          )];
      }))
      clang
      ninja
    ];
  }
