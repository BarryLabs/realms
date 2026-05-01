{
  flake.nixosModules.obs = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.obs-studio
    ];
  };
  flake.homeModules.obs = {pkgs, ...}: {
    programs = {
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          input-overlay
          obs-vkcapture
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
    };
  };
}
