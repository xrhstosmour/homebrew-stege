cask "stege" do
  version "0.8.1"
  sha256 "9a71ac173e7e726cfd191760a4504c4b1b7211e1af2f7ce49f2a7893ea99f32e"

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
