# NixOS Configuration

## Directory Structure
```
.
├── flake.lock
├── flake.nix
├── secrets.nix # agenix: public keys allowed to decrypt files in ./secrets
├── secrets # Encrypted age secret files (safe to commit)
├── hosts # Host-specific configurations
│   └── host
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules # Reusable NixOS modules
│   ├── home
│   │   ├── apps
│   │   ├── desktop
│   │   ├── services
│   │   └── theme
│   └── nixos
│       ├── core
│       ├── desktop
│       ├── services
│       └── users
└── users # User-specific Home Manager configurations.
    └── user
        └── default.nix
```

## Commands
| Action | Command |
| :--- | :--- |
| **Apply Configuration** | `sudo nixos-rebuild switch --flake .#<hostname>` |
| **Build Configuration** | `nixos-rebuild build --flake .#<hostname>` |
| **Dry Run (Check)** | `nixos-rebuild dry-run --flake .#<hostname>` |
| **Check Flake Syntax** | `nix flake check` |
| **Show Flake Outputs** | `nix flake show` |
| **Update Inputs** | `nix flake update` |
| **Edit Secret** | `nix run .#agenix -- -e secrets/<name>.age` |
| **Decrypt Secret** | `nix run .#agenix -- -d secrets/<name>.age` |
| **Rekey All Secrets** | `nix run .#agenix -- -r` |

## Secrets (agenix)

Secrets are encrypted with [age](https://age-encryption.org/) using SSH public keys as recipients, and decrypted on each host at activation time with the host's `/etc/ssh/ssh_host_ed25519_key`. The encrypted `.age` files live in `./secrets` and are safe to commit.

- Recipients are listed in `secrets.nix` (keyed by file path, e.g. `"secrets/foo.age"`).
- To add a host: `cat /etc/ssh/ssh_host_ed25519_key.pub` on that host, add it to `secrets.nix`, then run `nix run .#agenix -- -r` to re-encrypt.
- Create/edit a secret: `nix run .#agenix -- -e secrets/foo.age` (opens `$EDITOR`; use `-i ~/.ssh/id_ed25519` if your key is not auto-detected).

### Using a secret in a NixOS config
```nix
{
  age.secrets."foo.age" = {
    file = ../../secrets/foo.age;
    owner = "daniel";
    mode = "0400";
  };
  # decrypted file is at config.age.secrets."foo.age".path (/run/agenix/foo.age)
}
```

### Using a secret in home-manager
```nix
{
  age = {
    identityPaths = [ "~/.ssh/id_ed25519" ];
    secrets."foo.age" = {
      file = ../../secrets/foo.age;
      mode = "0600";
    };
  };
}
```
