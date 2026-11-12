cask "meeting-reminder-electron" do
  version "0.3.0"
  sha256 "8f9e1b2e631b3f6a8979da566fd771ef17cd9a739b8f0c6d36ee071b46f1c8bc"

  url "https://github.com/bbxytl/meeting-reminder-electron/releases/download/v#{version}/MeetingReminder-#{version}-arm64.dmg"
  name "Meeting Reminder"
  desc "macOS 菜单栏会议提醒：全屏遮罩 + 一键加入会议"
  homepage "https://github.com/bbxytl/meeting-reminder-electron"

  # 用符号而非字符串比较：Homebrew 6.0 起
  # `depends_on macos: ">= :ventura"` 已废弃并会打警告。
  depends_on macos: :ventura
  depends_on arch: :arm64

  app "MeetingReminder.app"

  # 应用仅 ad-hoc 签名，未经 Apple 公证。不摘掉 quarantine 属性，
  # 用户首次打开会被 Gatekeeper 拦下并提示「无法验证开发者」。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MeetingReminder.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/meeting-reminder-electron",
    "~/Library/Preferences/com.bbxytl.meeting-reminder.plist",
    "~/Library/Caches/com.bbxytl.meeting-reminder",
    "~/Library/Saved Application State/com.bbxytl.meeting-reminder.savedState",
  ]
end
