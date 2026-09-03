cask "stege" do
  version "0.44.0"
  sha256 "f2cfac7532ecea4e4c17d7ee4828a306c26a26b614d77a3a1bd12b8adb7a2f02"

  url "https://github.com/xrhstosmour/stege/releases/download/v#{version}/Stege.zip"
  name "Stege"
  desc "Menu bar replacement with AeroSpace and yabai support"
  homepage "https://github.com/xrhstosmour/stege"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Matches the app target's MACOSX_DEPLOYMENT_TARGET. Homebrew only accepts
  # named releases here, not point versions, so the app's minimum has to be a
  # whole release for this to be true: it was 14.6 once, which let 14.0 through
  # 14.5 install a binary macOS then refused to launch.
  depends_on macos: :sonoma

  app "Stege.app"

  # Stege is signed, but with a self-signed certificate rather than an Apple
  # Developer ID, so it cannot be notarised without a paid Apple account.
  # Gatekeeper refuses to launch it while the download still carries the
  # quarantine flag, and the user is shown "Stege.app Not Opened" with no
  # working way past it. Clearing the flag is what makes the cask installable.
  #
  # What stands in for notarisation: Homebrew has already checked the download
  # against the sha256 above, and the release it came from is built by GitHub
  # Actions with build provenance attestation, so the archive traces back to
  # the commit and workflow that produced it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Stege.app"]
  end

  zap trash: [
    "~/.config/stege",
    "~/.stege-config.toml",
    # Written beside the configuration when an older one is migrated.
    "~/.stege-config.toml.backup",
    "~/Library/Application Support/stege",
    "~/Library/Caches/com.xrhstosmour.stege",
    "~/Library/HTTPStorages/com.xrhstosmour.stege",
    "~/Library/Preferences/com.xrhstosmour.stege.plist",
    "~/Library/Saved Application State/com.xrhstosmour.stege.savedState",
  ]

  caveats <<~EOS
    Stege replaces the system menu bar, so hide the system one:
      System Settings > Control Center > Automatically hide and show the menu bar > Always

    It needs Accessibility permission to read the frontmost app's menus and to
    drive them. macOS will prompt on first launch.

    The Spaces widget needs AeroSpace or yabai.

    Upgrading from 0.30.0 or older rewrites your configuration in place, because
    four widget identifiers and the appearance section were renamed. The
    original is kept beside it as config.toml.backup.
  EOS
end
