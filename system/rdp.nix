{ system, ... }: {
  programs.weylus = {
    enable = true;
    openFirewall = true;
    users = [ "khabib" ];
    package =
      let
        system = "x86_64-linux";
        pkgs = import (builtins.fetchGit {
          name = "weylus-bump";
          url = "https://github.com/ZainKergaye/nixpkgs/";
          ref = "refs/heads/weylus-bump";
          rev = "5825be3485ad3ec65c4dfb8f53a522e7710e71a8";
        }) { inherit system; };
        myPkg = pkgs.weylus;
      in
      myPkg;
  };

}
