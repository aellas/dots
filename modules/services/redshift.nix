{
  location.latitude = 51.509865;
  location.longitude = -0.118092;
  
  services.redshift = {
    enable = true;

    temperature = {
      day = 5700;
      night = 3500;
    };

    brightness = {
      day = "1";
      night = "0.8";
    };

    extraOptions = [
      "-v"
      "-m randr"
    ];
  };
}