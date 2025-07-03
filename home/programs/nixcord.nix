{
  programs.nixcord = {
    enable = true;
    quickCss = "some CSS";
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://capnkitten.github.io/BetterDiscord/Themes/Material-Discord/css/source.css"
      ];
      frameless = false;
      plugins = {
        hideAttachments.enable = true;
        clearURLs.enable = true;
        betterFolders.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
    extraConfig = {
    };
  };
  # ...
}
