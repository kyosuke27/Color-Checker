import Foundation
import SwiftUI

protocol FavoriteColorRepository {
    func saveColor(_ color: [ColorData])
    func getColor() -> [ColorData]
    func deletecolor(_ color: ColorData)
}
