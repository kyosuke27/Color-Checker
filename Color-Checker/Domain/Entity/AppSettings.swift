import Foundation
import Combine

final class AppSettings: ObservableObject {
    let id: String
    @Published var themeColor: SettingImageType

    init(id: String, themeColor: SettingImageType) {
        self.id = id
        self.themeColor = themeColor
    }
}
