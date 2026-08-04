{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.helium.packages.${stdenv.hostPlatform.system}.default
  ];

}
