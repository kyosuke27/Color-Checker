import Foundation

struct AppSettingsRepositoryImpl:AppSettingsRepository{
    let iosManager:IOSFileManger
    let fileName = "AppSettings"
    init(iosManager: IOSFileManger = IOSFileMangerImpl()) {
        self.iosManager = iosManager
    }
    func read() -> AppSettings {
        do{
            let appSettings:AppSettings = try iosManager.getData(fileName: fileName)
            return appSettings
        }catch FileException.fileNotFound(let url){
            print("file not founc \(url)")
            return AppSettings(id: UUID().uuidString, themeColor: SettingImageType.defaultImage)
        }catch{
            fatalError()
        }
    }
    
    func save(_ appSettins:AppSettings) {
        iosManager.saveData(fileName: fileName, data: appSettins)
    }
    
    
}
