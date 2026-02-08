import Foundation
import SwiftUI

enum TabData:String,CaseIterable{
    case home = "Home"
    case favorite = "Favorite"
    
    var systemImage:String{
        switch self{
        case .home:
            return "drop.halffull"
        case .favorite:
            return "star"
        }
    }
    
    var index:Int{
        return TabData.allCases.firstIndex(of: self) ?? 0
    }
}

