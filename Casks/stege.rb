cask "stege" do
  version "0.4.1"
  sha256 "d43c561b13fb17b3d9b2de82d6ba15640d10431f0f0337f295ab013c137cd162"

  url "https://github.com/xrhstosmour/stege/releases/download/v#{version}/Stege.zip"
  name "Stege"
  desc "Menu bar replacement with AeroSpace and yabai support"
  homepage "https://github.com/xrhstosmour/stege"

  # Matches MACOSX_DEPLOYMENT_TARGET in the Xcode project.
  depends_on macos: :sonoma

  app "Stege.app"

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
