cask "stege" do
  version "0.16.0"
  sha256 "b41fe272a66a72c1b04e649bd4d5ef0e9589448094e95480f5d482c5733c2491"

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
