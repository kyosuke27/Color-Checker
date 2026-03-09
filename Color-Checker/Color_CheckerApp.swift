import SwiftUI
import GoogleMobileAds

@main
struct Color_CheckerApp: App {
    @StateObject private var appSettings: AppSettings
    init() {
        let repository: AppSettingsRepository = AppSettingsRepositoryImpl()
        _appSettings = StateObject(wrappedValue: repository.read())
        MobileAds.shared.start()
        print("✅initial MobileAds")
    }
    var body: some Scene {
        WindowGroup {
            AppScreen()
                .environmentObject(appSettings)
        }
    }
}
