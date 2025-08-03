{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [pyprland.variables]
      term_classed = "ghostty --class"

    [scratchpads.term]
      animation = "fromTop"
      command = "ghostty -e"
      class = "ghostty -e"
      size = "75% 60%"
      max_size = "1920px 100%"

    [scratchpads.rmpc]
    animation = "fromTop"
    command = "ghostty -e rmpc"
    class = "ghostty -e"
    size = "75% 75%"
    max_size = "1920px 100%"
    position = "150px 150px"
 
  '';
}