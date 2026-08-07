{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    proton-ge-bin
  ];

}
