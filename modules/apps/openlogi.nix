{
  openlogi,
  ...
}:
{
  imports = [
    openlogi.nixosModules.default
  ];

  programs.openlogi = {
    enable = true;
  };
}
