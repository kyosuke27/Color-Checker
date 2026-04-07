import Foundation
import SwiftUI

protocol Theme {
    var id: String {get}
    var fontColor: Color { get }
    var borderColor: Color {get}
    var borderButtonColor: Color {get}
    var textBackgroundColor: Color {get}
    var textFildIconColor: Color {get}
    var registerButtonBackgroundColor: Color {get}
    var registerButtonFontColor: Color {get}
}
