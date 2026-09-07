{
  flake.nixosModules.oci-copyparty-rootless = {
    config,
    pkgs,
    lib,
    ...
  }: let
    user = "copyparty";
    group = "copyparty";
    uid = 989;
    gid = 983;
    home = "/var/lib/copyparty";

    quadletFile = pkgs.writeText "copyparty-rootless.container" ''
      [Unit]
      Description=copyparty (rootless quadlet)
      Wants=network-online.target
      After=network-online.target

      [Container]
      Image=docker.io/copyparty/ac:latest
      ContainerName=copyparty
      PublishPort=0.0.0.0:3923:3923/tcp
      User=${toString uid}:${toString gid}
      Group=${toString gid}
      UserNS=keep-id:uid=${toString uid},gid=${toString gid}
      Environment=LD_PRELOAD=/usr/lib/libmimalloc-secure.so.NOPE
      Environment=PYTHONUNBUFFERED=1
      Volume=/srv/copyparty/cfg:/cfg:Z
      Volume=/srv/copyparty/files:/files:Z
      NoNewPrivileges=true
      DropCapability=ALL
      AddCapability=CHOWN
      AddCapability=SETGID
      AddCapability=SETUID

      [Service]
      Restart=always
      TimeoutStartSec=900

      [Install]
      WantedBy=default.target
    '';
  in {
    users.users.${user} = {
      isSystemUser = true;
      inherit uid home;
      group = group;
      createHome = true;
      linger = true; # keeps user@<uid>.service alive after logout, so container starts at boot
    };

    users.groups.${group} = {
      gid = gid;
    };

    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };

    networking.firewall.interfaces = let
      matchAll =
        if !config.networking.nftables.enable
        then "podman+"
        else "podman*";
    in {
      "${matchAll}".allowedUDPPorts = [53];
    };

    # Drop the rootless Quadlet file into the user's containers/systemd directory.
    # On boot, the user manager reads it and generates copyparty.service.
    systemd.tmpfiles.rules = [
      "d ${home}/.config 0755 ${user} ${group} - -"
      "d ${home}/.config/containers 0755 ${user} ${group} - -"
      "d ${home}/.config/containers/systemd 0755 ${user} ${group} - -"
      "L+ ${home}/.config/containers/systemd/copyparty.container - - - - ${quadletFile}"
    ];

    # Make sure the user manager starts at boot (linger covers this, but being explicit
    # means the unit is pulled into multi-user.target ordering).
    systemd.services."user@${toString uid}" = {
      wantedBy = ["multi-user.target"];
    };

    # After the user manager is up, reload it and start the generated Quadlet service.
    # Running the activation script as the copyparty user lets `systemctl --user`
    # talk to the correct user bus.
    systemd.services.copyparty-rootless-activate = {
      after = ["user@${toString uid}.service"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        User = user;
        Group = group;
      };
      path = [pkgs.systemd pkgs.podman];
      script = ''
        systemctl --user daemon-reload
        systemctl --user start copyparty.service || true
      '';
    };
  };
}
