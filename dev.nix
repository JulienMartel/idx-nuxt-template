{pkgs, packageManager, ...}: {
  channel = "stable-23.05"; # "stable-23.05" or "unstable"
  packages = [
    pkgs.nodejs
    pkgs.yarn
    pkgs.nodePackages.pnpm
  ];

  # Sets environment variables in the workspace
  env = { };

  # search for the extension on https://open-vsx.org/ and use "publisher.id"
  idx.extensions = [
    "vue.volar"
  ];

  # runs when a workspace is first created with this `dev.nix` file
  # to run something each time the environment is rebuilt, use the `onStart` hook
  idx.workspace.onCreate = {
    install = "${packageManager} install";
  };

  idx.previews = {
    enable = true;
    previews = [
      {
        command = ["npm" "run" "dev" "--" "--port" "$PORT" "--hostname" "0.0.0.0"];
        manager = "web";
        id = "web";
      }
    ];
  };
}
