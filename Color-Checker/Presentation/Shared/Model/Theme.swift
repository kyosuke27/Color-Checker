import Foundation
import SwiftUI

protocol Theme {
    var id: String {get}
    var fontColor: Color { get }
    var borderColor: Color {get}
    var borderButtonColor: Color {get}
    var textFieldColor: TextFieldColor {get}
    var resetButtonColor: ResetButtonColor {get}
    var registerButtonColor: RegisterButtonColor {get}
    var tagColor: TagColor {get}
    var tagButtonColor: TagButton {get}
    var rgbArea: RGBArea {get}
}
