{ pkgs, packageManager, ... }: {

    packages = [
      pkgs.nodejs
      pkgs.git
    ];

    # Available options as of 1/17/2024
    # https://github.com/nuxt/cli/blob/f113a083f000d19c9ae7f35ae2534ac5c0dba77b/src/commands/init.ts
    # npx nuxi@latest init nuxt-idx --package-manager pnpm --install true --git-init true --force true

    # To test this configuration:
    # /nix/store/mvr5wczap3ga80iq548n2griy8kx9ksx-idx-template/bin/idx-template ~/Monospace/workspace/nix_templates/nuxt --output-dir ~ --workspace-name foo -a '{"packageManager": "yarn", "install": true}'

    bootstrap = ''
      sed -i "s/PACKAGE_MANAGER/${packageManager}/g" ${./dev.nix}

      npx nuxi@latest -y init "$out" \
        --package-manager ${packageManager} \
        --no-install \
        --git-init \
        --force

      mkdir "$out"/.idx
      cp ${./dev.nix} "$out"/.idx/dev.nix
      chmod -R +w "$out"
    '';
}