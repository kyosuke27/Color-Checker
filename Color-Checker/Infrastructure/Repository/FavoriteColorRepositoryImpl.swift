import Foundation
import SwiftUI

struct FavoriteColorRepositoryImpl: FavoriteColorRepository {
    let iosFileManager: IOSFileManger
    let fileName = "FavoriteColor.json"

    init(iosFileManager: IOSFileManger = IOSFileMangerImpl()) {
        self.iosFileManager = iosFileManager
    }

    func saveColor(_ colorData: [ColorData]) {
        iosFileManager.saveData(fileName: fileName, data: colorData)
    }

    func getColor() -> [ColorData] {
        do {
            let colors: [ColorData] = try iosFileManager.getData(fileName: fileName)
            return colors
        } catch FileException.fileNotFound(let url) {
            print("file not found : \(url)")
            // FileNotFoundは空を返す
            return []
        } catch {
            fatalError()
        }
    }

    func deletecolor(_ color: ColorData) {
    }

}
