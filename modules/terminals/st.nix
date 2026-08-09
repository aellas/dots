{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.st.packages.${stdenv.hostPlatform.system}.st-snazzy
    herdr
  ];

}
