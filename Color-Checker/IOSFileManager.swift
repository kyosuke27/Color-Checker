import Foundation

protocol IOSFileManger{
    // 対象の型をローカルファイルから取得する
    // ジェネリクスとしてT型を定義
    func getData<T:Codable>(fileName:String)->T
    // ジェネリクス型を保存
    func saveData<T:Codable>(fileName:String,data:T)->Void
    
}

struct IOSFileMangerImpl:IOSFileManger{
    func getData<T>(fileName: String) -> T where T : Decodable, T : Encodable {
        let fileManager = FileManager.default
        // userDomainMask : ユーザーのホームディレクトリ
        // documentDirectory : アプリ固有のドキュメントディレクトリ
        guard let userDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        
        let url = userDocumentDirectory.appending(components: fileName)
        print("url : \(url)")
        
        guard fileManager.fileExists(atPath: url.path) else{
            fatalError()
        }
        do{
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self,from: data)
        }catch{
            fatalError()
        }
    }
    
    func saveData<T>(fileName: String, data: T) where T : Decodable, T : Encodable {
        let fileManger = FileManager.default
        guard let userDocumentDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else{
            fatalError()
        }
        let url = userDocumentDirectory.appending(components: fileName)
        print("url : \(url)")
        do{
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: url, options: [.atomic])
        }catch{
            fatalError()
        }
    }
    
    
}
