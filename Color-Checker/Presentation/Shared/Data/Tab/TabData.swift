import Foundation
import SwiftUI

enum TabData: String, CaseIterable {
    case home = "Home"
    case favorite = "Favorite"
    case setting = "Setting"

    var systemImage: String {
        switch self {
        case .home:
            return "drop.halffull"
        case .favorite:
            return "star"
        case .setting:
            return "gear"
        }

    }

    var index: Int {
        return TabData.allCases.firstIndex(of: self) ?? 0
    }
}
