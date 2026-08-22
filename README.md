# homebrew-stege

Homebrew tap for [Stege](https://github.com/xrhstosmour/stege), a macOS menu bar
replacement with `AeroSpace` and `yabai` support.

```bash
brew tap xrhstosmour/stege
brew install --cask stege
```

## How releases reach this tap

Tagging `v*` in the `stege` repository builds the app, signs it, attests its build
provenance and publishes a GitHub release. The cask here is then updated to the new version
and checksum through a pull request. The tap is never pushed to directly, so what
`brew install` resolves to cannot change without review.

Verify any release came from that workflow:

```bash
gh attestation verify Stege.zip --repo xrhstosmour/stege
```

## Signing

Stege is signed with a self-signed certificate, not an Apple Developer ID, so it is **not**
notarized. Gatekeeper will refuse the first launch with `"Stege.app" Not Opened`. Open System
Settings, Privacy & Security, scroll to the bottom and choose Open Anyway.

What stands in for notarization is the checksum in the cask, which Homebrew verifies on every
install, and the build provenance attestation above, which ties the archive back to the commit
and workflow that produced it.
