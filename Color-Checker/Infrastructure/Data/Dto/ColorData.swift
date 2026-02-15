import Foundation

struct ColorData: Codable, Identifiable {
    let id: String
    let red: Int
    let green: Int
    let blue: Int
    let alpha: Float
    let hexColor: String
}
