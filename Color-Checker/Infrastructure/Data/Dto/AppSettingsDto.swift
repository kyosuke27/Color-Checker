import Foundation

// 登録用
struct AppSettingsDto: Codable, Identifiable {
    let id: String
    let themeColor: SettingImageType
}
