import Foundation

enum SettingImageType: Int, CaseIterable,Codable{
    case defaultImage = 1
    case lightImage = 2
    case grayColor = 3
    
    // SwiftUIのコンポーネントは返さない
    // 文字列の方が汎用性がある
    var stringValue: String {
        switch self {
        case .defaultImage:
            return "Background"
        case .lightImage:
            return "LightColor"
        case .grayColor:
            return "GrayColor"
            
        }
    }
}
