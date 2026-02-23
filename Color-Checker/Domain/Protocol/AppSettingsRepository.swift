import Foundation

protocol AppSettingsRepository {
    func read() -> AppSettings
    func save(_ appSettins: AppSettings)
}
