{config, ...}: {
  flake.nixosModules.locale = {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ALL = "en_US.UTF-8";
      };
    };
  };
}
