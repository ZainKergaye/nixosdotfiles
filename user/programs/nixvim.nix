{self, pkgs, nixvim, ...}: 
{
programs.nixvim = {
  enable = true;
  defaultEditor = true;
  
  viAlias = true;
  vimAlias = true;
  plugins = {
    lightline.enable = true;
  };

  options = {
    shiftwidth = 2;
  };
};

}
