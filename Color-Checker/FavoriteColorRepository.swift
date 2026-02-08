import Foundation
import SwiftUI

protocol FavoriteColorRepository{
    func saveColor(_ color:[ColorData])
    func getColor() -> [ColorData]
}

struct FavoriteColorRepositoryImpl:FavoriteColorRepository{
    let IosFileManager = IOSFileMangerImpl()
    let fileName = "FavoriteColor.json"
    
    func saveColor(_ colorData: [ColorData]) {
        IosFileManager.saveData(fileName: fileName, data: colorData)
    }
    
    func getColor()->[ColorData] {
        return IosFileManager.getData(fileName: fileName)
    }
    
    
}
