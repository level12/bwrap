# Bubblewrap Binary Releases

Unofficial builds & releases of https://github.com/containers/bubblewrap/

Created to be used with [mise's ubi backend](https://mise.jdx.dev/dev-tools/backends/ubi.html) so
the latest release of bubblewrap would be easily available for projects that depend on it.

## Target Platforms

Currently, only Ubuntu latest x64.

PRs welcome that add support for other platforms.

## Usage w/ mise

```toml
# mise.toml
[tools]
"ubi:level12/bwrap" = "latest"
```

## New Release

When upstream releases, just add a new version tag to this repo to mirror their release.  GitHub
actions will then build and release.


## Local Build

If you want to test the build script locally, see
[build.yml](https://github.com/level12/bwrap/blob/main/.github/workflows/build.yml) for the apt
dependencies.

Then just `./build.sh`.
