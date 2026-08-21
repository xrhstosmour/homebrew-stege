cask "abaxion" do
  version "0.1.0"
  # Placeholder until the first release. Deliberately a real (wrong) checksum
  # rather than `:no_check`, so an install attempt fails loudly instead of
  # silently skipping verification. The release workflow rewrites both lines.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/xrhstosmour/abaxion/releases/download/v#{version}/Abaxion.zip"
  name "Abaxion"
  desc "Menu bar replacement with AeroSpace and yabai support"
  homepage "https://github.com/xrhstosmour/abaxion"

  # Matches MACOSX_DEPLOYMENT_TARGET in the Xcode project.
  depends_on macos: ">= :sonoma"

  app "Abaxion.app"

  zap trash: [
    "~/.abaxion-config.toml",
    "~/.config/abaxion",
    "~/Library/Application Support/abaxion",
    "~/Library/Preferences/com.xrhstosmour.abaxion.plist",
  ]

  caveats <<~EOS
    Abaxion replaces the system menu bar, so hide the system one:
      System Settings > Control Center > Automatically hide and show the menu bar > Always

    It needs Accessibility permission to read the frontmost app's menus and to
    drive them. macOS will prompt on first launch.

    The Spaces widget needs AeroSpace or yabai.
  EOS
end
