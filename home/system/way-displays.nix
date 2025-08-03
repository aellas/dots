{
  services.way-displays = {
    enable = true;
    settings = {
      MODE = [
        {
          NAME_DESC = "DP-4";
          WIDTH = 1920;
          HEIGHT = 1080;
          HZ = 240;
        }
        {
          NAME_DESC = "DP-3";
          WIDTH = 1920;
          HEIGHT = 1080;
          HZ = 240;
        }
        {
          NAME_DESC = "eDP-1";
          WIDTH = 1920;
          HEIGHT = 1080;
          SCALE = 1;
          HZ = 60;
        }
      ];
      DISABLED = [
        {
          NAME_DESC = "eDP-1";
          IF = [
            { PLUGGED = [ "DP-4" "DP-3"]; }
          ];
        }
      ];
      VRR_OFF = [
        "VG279QM"
        "eDP-1"
      ];
      VERBOSE = true;
    };
  };
}
