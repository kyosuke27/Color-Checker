import Foundation
import SwiftUI

protocol FavoriteColorRepository {
    func saveColor(_ color: [ColorData])
    func getColor() -> [ColorData]
    func deleteColor(_ id: String)
}
