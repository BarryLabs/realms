{config, ...}: {
  flake.nixosModules.ghidra = {
    environment.sessionVariables =
      if config.programs.niri.enable
      then {
        _JAVA_AWT_WM_NONREPARENTING = "1";
      }
      else {};
    programs = {
      ghidra = {
        enable = true;
      };
    };
  };
}
