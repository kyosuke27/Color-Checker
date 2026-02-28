import Foundation

protocol TagRepository {
    func readAll() -> [Tag]
    func readById(id: String) -> [Tag]
    func save(_ tags: [Tag])
    func update(_ tag: Tag)
}
