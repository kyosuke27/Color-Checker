import Foundation

struct TagRepositoryImpl: TagRepository {
    let iosManager: IOSFileManger
    let fileName = "Tags"
    let tag = "TagRepositoryImpl"
    init(iosManager: IOSFileManger = IOSFileMangerImpl()) {
        self.iosManager = iosManager
    }

    func readAll() -> [Tag] {
        do {
            let data: [Tag] = try iosManager.getData(fileName: fileName)
            return data
        } catch FileException.fileNotFound(let url) {
            print("\(tag) file not found : \(url)")
            // FileNotFoundは空を返す
            return []
        } catch {
            fatalError("\(tag) readAll error")
        }    }

    func readById(id: String) -> [Tag] {
        do {
            let data: [Tag] = try iosManager.getData(fileName: fileName)
            let filteredData = data.filter {
                $0.id == id
            }
            return filteredData
        } catch FileException.fileNotFound(let url) {
            print("\(tag) file not found : \(url)")
            // FileNotFoundは空を返す
            return []
        } catch {
            fatalError("\(tag) readById error")
        }
    }

    func save(_ tags: [Tag]) {
        iosManager.saveData(fileName: fileName, data: tags)
    }

    func update(_ tag: Tag) {
        do {
            var data: [Tag] = try iosManager.getData(fileName: fileName)
            if let index = data.firstIndex(where: { $0.id == tag.id }) {
                data[index] = tag
                iosManager.saveData(fileName: fileName, data: data)
            } else {
              fatalError("\(tag) tag not found")
            }
        } catch FileException.fileNotFound(let url) {
            fatalError("\(tag) readById error \(url)")
        } catch {
            fatalError("\(tag) readById error")
        }
    }
    func delete(_ tag: Tag) {
        do {
            var data: [Tag] = try iosManager.getData(fileName: self.fileName)
            if let index = data.firstIndex(where: { $0.id == tag.id }) {
                // 削除
                data.remove(at: index)
                iosManager.saveData(fileName: fileName, data: data)
            } else {
              fatalError("\(tag) tag not found")
            }
        } catch FileException.fileNotFound(let url) {
            fatalError("\(tag) delete fileNotFound error \(url)")
        } catch {
            fatalError("\(tag) readById error")
        }
    }
}
