import Foundation

enum SettingImageType: Int, CaseIterable, Codable {
    case light = 1
    case darkImage = 2
    case blueColor = 3
    case defaultImage = 4

    // SwiftUIのコンポーネントは返さない
    // 文字列の方が汎用性がある
    var stringValue: Theme {
        switch self {
        case .defaultImage:
            return defaultTheme()

        case .darkImage:
            return darkColorTheme()

        case .blueColor:
            return blueTheme()
            
        case .light:
            return LightColorTheme()

        }
    }
}
