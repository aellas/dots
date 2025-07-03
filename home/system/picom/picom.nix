{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [ pkgs.picom ];

  xdg.configFile."picom/picom.conf".source = ./picom.conf;

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom compositor";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.picom} --config=${config.xdg.configHome}/picom/picom.conf";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
