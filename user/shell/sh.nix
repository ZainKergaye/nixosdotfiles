{ config, lib, pkgs, ... }:

let 
  myAliases = {
    lalala = "ls -la";
    reee = "cd ..";
  };

in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
