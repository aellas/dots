{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.librewolf = {
    enable = true;

    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "menupanel";
          private_browsing = true;
        };

        "proton-pass@proton.me" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          default_area = "menupanel";
          private_browsing = true;
        };

        "protonvpn@proton.me" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          default_area = "menupanel";
          private_browsing = true;
        };
      };
    };
  };
}
