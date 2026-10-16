cask "notchcontrol" do
  version "0.1.2"
  sha256 "fe59b200957a6edf0fe5ec59aa0c2087cea47912537437f3ede7f00bb9f39c71"

  url "https://github.com/tariqp/notchcontrol/releases/download/v#{version}/NotchControl-#{version}.zip"
  name "NotchControl"
  desc "Notch companion for Claude Code, Codex, Copilot and Gemini CLI"
  homepage "https://github.com/tariqp/notchcontrol"

  depends_on macos: ">= :sonoma"

  app "NotchControl.app"

  # Ad-hoc signed, not notarized: drop the quarantine flag so Gatekeeper lets it open.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NotchControl.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/NotchControl",
    "~/Library/Preferences/io.github.tariqp.notchcontrol.plist",
  ]

  caveats <<~EOS
    NotchControl is ad-hoc signed, not notarized; the quarantine flag is removed on install.
    If macOS still refuses to open it: xattr -dr com.apple.quarantine /Applications/NotchControl.app

    On first launch macOS asks for a few permissions. All are optional:
      Calendars                    the Calendar tab and "event in N min" in the notch
      Notifications                reminder and approval alerts
      Automation: Music, Spotify   the Music tab
      Automation: Terminal, iTerm2 jump to the tab an agent runs in, reply from the notch
      Bluetooth                    connected devices and battery warnings
    Change them later in System Settings > Privacy & Security. Without an Apple Developer
    signature macOS asks again after every upgrade.

    Then open Settings in NotchControl and click "Install hooks" for your agents.
  EOS
end
