import Foundation
import SwiftUI

struct ColorCheckerState {
    var red: Int
    var green: Int
    var blue: Int
    var opacity: Double
    var memoText: String
    var isShowToast: Bool
    var errorMessage: String
    var colorCheckerType: ColorCheckerType
    var tagData: Tag
    
    var color: Color {
        get {
            return Color.rgba(r: red.intToDouble(), g: green.intToDouble(), b: blue.intToDouble(), a: opacity)
        }
    }
}
