import Foundation

protocol IOSFileManger {
    // 対象の型をローカルファイルから取得する
    // ジェネリクスとしてT型を定義
    func getData<T: Codable>(fileName: String) throws -> T
    // ジェネリクス型を保存
    func saveData<T: Codable>(fileName: String, data: T)

}

struct IOSFileMangerImpl: IOSFileManger {
    // TはCodableに準拠している変数
    func getData<T: Codable>(fileName: String) throws -> T {
        let fileManager = FileManager.default
        // userDomainMask : ユーザーのホームディレクトリ
        // documentDirectory : アプリ固有のドキュメントディレクトリ
        guard let userDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError()
        }

        let url = userDocumentDirectory.appending(components: fileName)
        print("url : \(url)")

        guard fileManager.fileExists(atPath: url.path) else {
            throw FileException.fileNotFound(url)
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError()
        }
    }

    func saveData<T: Codable>(fileName: String, data: T) {
        let fileManager = FileManager.default
        guard let userDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        let url = userDocumentDirectory.appending(components: fileName)
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: url, options: [.atomic])
            print("complete color data saving")
        } catch {
            fatalError()
        }
    }

}
