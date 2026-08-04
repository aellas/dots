{
  pkgs,
  helium,
  ...
}:

{
  home.packages = with pkgs; [
    helium.packages.${stdenv.hostPlatform.system}.default
  ];

}
