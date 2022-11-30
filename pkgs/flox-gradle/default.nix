{callPackage,pkgs,...}:
    let
      buildGradle = callPackage ./gradle-env.nix {};
    in
      buildGradle {
        pname = "flox-gradle";
        nativeBuildInputs = with pkgs; [ makeWrapper openjdk ];
        envSpec = ./gradle-env.json;
        src = ../..;
         gradleFlags = [ "distTar" ];

         installPhase = ''
           ls -al app/build
           mkdir $out
           pushd app/build/distributions
           tar -xf *.tar
           cp -r */* $out
           wrapProgram $out/bin/app --prefix PATH : ${pkgs.openjdk}/bin
           popd
         '';
      }
