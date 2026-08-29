cask "stege" do
  version "0.13.0"
  sha256 "2f488b77430edf363331fb3eb8e5a8aa4eaa3c6ce6e4a826de669cb8c4952f52"

  url "https://github.com/xrhstosmour/stege/releases/download/v#{version}/Stege.zip"
  name "Stege"
  desc "Menu bar replacement with AeroSpace and yabai support"
  homepage "https://github.com/xrhstosmour/stege"

  # Matches MACOSX_DEPLOYMENT_TARGET in the Xcode project.
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
    "~/.stege-config.toml",
    "~/.config/stege",
    "~/Library/Application Support/stege",
    "~/Library/Preferences/com.xrhstosmour.stege.plist",
  ]

  caveats <<~EOS
    Stege replaces the system menu bar, so hide the system one:
      System Settings > Control Center > Automatically hide and show the menu bar > Always

    It needs Accessibility permission to read the frontmost app's menus and to
    drive them. macOS will prompt on first launch.

    The Spaces widget needs AeroSpace or yabai.
  EOS
end
