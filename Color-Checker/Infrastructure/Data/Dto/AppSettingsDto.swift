import Foundation

struct AppSettingsDto: Codable, Identifiable {
    let id: String
    let themeColor: SettingImageType
}
