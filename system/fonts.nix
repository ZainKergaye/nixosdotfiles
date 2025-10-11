{ pkgs, ... }:
{
  fonts.packages =
    with pkgs;
    [
      font-awesome

    ]
    ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues nerd-fonts));

}
