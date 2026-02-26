import Foundation

struct TagRepositoryImpl: TagRepository {
    let iosManager: IOSFileManger
    let fileName = "Tags"
    init(iosManager: IOSFileManger = IOSFileMangerImpl()) {
        self.iosManager = iosManager
    }

    func readAll() -> [Tag] {
        return  []
    }

    func readById(id: String) -> Tag {
        let data = iosManager.getData(fileName: fileName)
        let filteredData
        return Tag(id: "", tagName: "sample")
    }

    func save(_ tags: [Tag]) {
        iosManager.saveData(fileName: fileName, data: tags)
    }

}
