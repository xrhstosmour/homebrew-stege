cask "stege" do
  version "0.5.0"
  sha256 "6f1da669c5976b3668a723503f2f2a538f2986e4189c0573c3d3f515d6da6b43"

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
