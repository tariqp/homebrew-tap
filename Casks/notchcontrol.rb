cask "notchcontrol" do
  version "0.1.0"
  sha256 "fcd4925a1fc259ae7bc64df42a9157d45c33be6b3c593398e3c06803bf22e480"

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

    Open NotchControl, go to Settings and click "Install hooks" for your agents.
  EOS
end
