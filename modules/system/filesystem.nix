{
  pkgs,
  inputs,
  username,
  host,
  profile,
  ...
}:
{
    fileSystems."/mnt/Games" = {
     device = "/dev/disk/by-uuid/6415fb68-bd8c-4502-b1a6-7b8aed5f04c7";
     fsType = "btrfs";
  };

    fileSystems."/mnt/nix" = {
     device = "/dev/disk/by-uuid/a33b3e9e-c204-45af-887e-28dfa534939f";
     fsType = "ext4";
  };

    fileSystems."/mnt/Backup" = {
     device = "/dev/disk/by-uuid/68be1620-a9cf-4167-bf6b-6f8e9c9473ee";
     fsType = "ext4";
  };

}