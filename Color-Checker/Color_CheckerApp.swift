import SwiftUI
import GoogleMobileAds

@main
struct Color_CheckerApp: App {
    @StateObject private var appSettings: AppSettings
    @StateObject private var interstitialViewModel: InterstitialViewModel
    init() {
        let repository: AppSettingsRepository = AppSettingsRepositoryImpl()
        _appSettings = StateObject(wrappedValue: repository.read())
        _interstitialViewModel = StateObject(wrappedValue: InterstitialViewModel())
        MobileAds.shared.start()
        print("✅initial MobileAds")
    }
    var body: some Scene {
        WindowGroup {
            AppScreen()
                .environmentObject(appSettings)
                .environmentObject(interstitialViewModel)
        }
    }
}
