import Foundation
import Combine

class AppState: ObservableObject {
    @Published var appSetting: AppSettings
    private let reposiroty: AppSettingsRepository
    init( reposiroty: AppSettingsRepository) {
        self.reposiroty = reposiroty
        self.appSetting = reposiroty.read()
    }
    
    func updateThemeColor(_ type: SettingImageType) {
        let newSettings = AppSettings(id: appSetting.id, themeColor: type)
        self.appSetting = newSettings
        reposiroty.save(self.appSetting)
    }
}
