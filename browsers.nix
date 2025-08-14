{ config, pkgs, ... }:

let
  # Path to Web eID JSON
  webEidJson = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";
in
{
  # Firefox setup
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.euwebid = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        # Automatically load system PKCS#11 modules
        "security.osclientcerts.autoload" = true;
      };
    };
  };

  # Brave setup
  programs.brave.enable = true;

  # Register Web eID native host for Brave/Chromium
  home.file.".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/eu.webeid.json".source = webEidJson;
  home.file.".config/chromium/NativeMessagingHosts/eu.webeid.json".source = webEidJson;

  # PKCS#11 module registration via p11-kit
  home.file.".p11-kit/modules/opensc.module".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';

  # Optional: Make OpenSC PKCS#11 module available for Firefox old-style loading
  home.file.".mozilla/pkcs11.txt".text = ''
    library=${pkgs.opensc}/lib/opensc-pkcs11.so
    name=OpenSC
  '';
}

