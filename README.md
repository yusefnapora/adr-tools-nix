# adr-tools-nix

> a nix flake wrapper around [`adr-tools`](https://github.com/npryce/adr-tools)

## Why?

Because I need it for work, and I'm too stubborn to install Homebrew on my work laptop.

## Usage

Requires a flake-enabled nix because I'm too lazy for back compat.

Run without installing:

```bash
nix run github:yusefnapora/adr-tools-nix new "Just use Postgres"
```

Add to your user profile:

```bash
nix profile install github:yusefnapora/adr-tools-nix
```

Add as an input to another flake:

```nix
{
  # in your flake.nix:
  inputs.adr-tools = {
    url = "github:yusefnapora/adr-tools-nix";
    inputs.nixpkgs.follows = "nixpkgs"; # not required, but saves on disk space & build time
  };

}

```

Then you can add the package to your nixos system with:

```nix
  environment.systemPackages = [ inputs.adr-tools ];
```

or using home-manager:

```nix
  home.packages = [ inputs.adr-tools ];
```
