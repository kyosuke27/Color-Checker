import SwiftUI

@main
struct Color_CheckerApp: App {
    @StateObject private var appSettings: AppSettings
    init() {
        let repository: AppSettingsRepository = AppSettingsRepositoryImpl()
        _appSettings = StateObject(wrappedValue: repository.read())
    }
    var body: some Scene {
        WindowGroup {
            AppScreen()
                .environmentObject(appSettings)
        }
    }
}
