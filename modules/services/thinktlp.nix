    
{ 
    services.tlp = {
    enable = true;
    settings = {
      # Platform
      PLATFORM_PROFILE_ON_BAT = "powersave";
      PLATFORM_PROFILE_ON_AC = "powersave";
        
      # Processor
      CPU_SCALING_MAX_FREQ_ON_AC = 3900000;
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
    };
  };
}