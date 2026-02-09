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
        do{
            let colors:[ColorData] = try IosFileManager.getData(fileName: fileName)
            return colors
        }catch FileException.fileNotFound(let url){
            print("file not found : \(url)")
            // FileNotFoundは空を返す
            return []
        }catch{
            fatalError()
        }
    }
    
    
}
