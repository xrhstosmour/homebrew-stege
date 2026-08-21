# homebrew-abaxion

Homebrew tap for [Abaxion](https://github.com/xrhstosmour/abaxion), a macOS menu bar
replacement with `AeroSpace` and `yabai` support.

```bash
brew install --cask xrhstosmour/abaxion/abaxion
```

## How releases reach this tap

Tagging `v*` in the `abaxion` repository builds, signs, notarizes and publishes the app, then
opens a pull request here with the new version and checksum. The tap is never pushed to
directly, so what `brew install` resolves to cannot change without review.

Verify any release came from that workflow:

```bash
gh attestation verify Abaxion.zip --repo xrhstosmour/abaxion
```
