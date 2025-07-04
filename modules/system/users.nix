{
  pkgs,
  inputs,
  username,
  host,
  profile,
  ...
}:

{
  users.users.array = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
      "audio"
      "render"
      "video"
    ];
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = ["array"];
}
