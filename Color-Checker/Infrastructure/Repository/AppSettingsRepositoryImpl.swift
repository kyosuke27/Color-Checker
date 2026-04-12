import Foundation

struct AppSettingsRepositoryImpl: AppSettingsRepository {
    let iosManager: IOSFileManger
    let fileName = "AppSettings"
    init(iosManager: IOSFileManger = IOSFileMangerImpl()) {
        self.iosManager = iosManager
    }
    func read() -> AppSettings {
        do {
            let appSettings: AppSettingsDto = try iosManager.getData(fileName: fileName)
            return mapToEntity(appSettings)
        } catch FileException.fileNotFound(let url) {
            // 新規作成
            print("file not founc \(url)")
            // UUIDはここだけで採番する
            return AppSettings(id: UUID().uuidString, themeColor: SettingImageType.defaultImage)
        } catch {
            fatalError()
        }
    }

    func save(_ appSettins: AppSettings) {
        iosManager.saveData(fileName: fileName, data: mapToDto(appSettins))
    }
    // Entityへ変換
    // アプリケーションで使用するモデル
    func mapToEntity(_ appSettingDto: AppSettingsDto) -> AppSettings {
        return AppSettings(id: appSettingDto.id, themeColor: appSettingDto.themeColor)
    }
    
    // 登録用のモデル
    func mapToDto(_ appSetting: AppSettings) -> AppSettingsDto {
        return AppSettingsDto(id: appSetting.id, themeColor: appSetting.themeColor)
    }

}
