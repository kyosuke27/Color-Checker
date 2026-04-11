import Foundation
import SwiftUI

public struct ResetButtonColor {
    let resetButtonFontColor: Color
    let resetButtonBackground: Color
}

public struct RegisterButtonColor {
    let registerButtonBackgroundColor: Color
    let registerButtonFontColor: Color
}

public struct TextFieldColor {
    let textBackgroundColor: Color
    let textFieldIconColor: Color
}

public struct TagColor {
    let tagBackground: Color
    let tagSelectBackground: Color
    let tagDeleteButtonBackgroundColor: Color
}

struct defaultTheme: Theme {
    let id: String = "Background"
    let fontColor: Color = Color("DarkBaseFont")
    let borderColor: Color = Color("DarkBorder")
    let borderButtonColor: Color = Color("Light")
    let textFieldColor: TextFieldColor = TextFieldColor(
        textBackgroundColor: Color("DarkBorder"),
        textFieldIconColor: Color("Light")
    )
    let resetButtonColor: ResetButtonColor = ResetButtonColor(
        resetButtonFontColor: Color("LightBlack"),
        resetButtonBackground: Color("LightBrawn")
    )
    let registerButtonColor: RegisterButtonColor = RegisterButtonColor(
        registerButtonBackgroundColor: Color("DarkLightPurple"),
        registerButtonFontColor: Color("Light")
    )
    let tagColor: TagColor = TagColor(
        tagBackground: Color("DarkTagBackground"),
        tagSelectBackground: Color("DarkSelectTagBackground"),
        tagDeleteButtonBackgroundColor: .white.opacity(0.1)
    )
}

struct blueTheme: Theme {
    let id: String = "BlueColor"
    let fontColor: Color = Color("DarkBaseFont")
    let borderColor: Color = Color("DarkBorder")
    let borderButtonColor: Color = Color("Light")
    let textFieldColor: TextFieldColor = TextFieldColor(
        textBackgroundColor: Color("DarkBorder"),
        textFieldIconColor: Color("Light")
    )
    let resetButtonColor: ResetButtonColor = ResetButtonColor(
        resetButtonFontColor: Color("LightBlack"),
        resetButtonBackground: Color("LightBrawn")
    )
    let registerButtonColor: RegisterButtonColor = RegisterButtonColor(
        registerButtonBackgroundColor: Color("DarkLightPurple"),
        registerButtonFontColor: Color("Light")
    )
    let tagColor: TagColor = TagColor(
        tagBackground: Color("DarkTagBackground"),
        tagSelectBackground: Color("DarkSelectTagBackground"),
        tagDeleteButtonBackgroundColor: .white.opacity(0.1)
    )
}

struct darkColorTheme: Theme {
    let id: String = "DarkColor"
    let fontColor: Color = Color("DarkBaseFont")
    let borderButtonColor: Color = Color("Light")
    let borderColor: Color = Color("DarkBorder")
    let textFieldColor: TextFieldColor = TextFieldColor(
        textBackgroundColor: Color("DarkBorder"),
        textFieldIconColor: Color("Light")
    )
    let resetButtonColor: ResetButtonColor = ResetButtonColor(
        resetButtonFontColor: Color("DarkBlack"),
        resetButtonBackground: Color("LightBrawn")
    )
    let registerButtonColor: RegisterButtonColor = RegisterButtonColor(
        registerButtonBackgroundColor: Color("DarkLightPurple"),
        registerButtonFontColor: Color("Light")
    )
    let tagColor: TagColor = TagColor(
        tagBackground: Color("DarkTagBackground"),
        tagSelectBackground: Color("DarkSelectTagBackground"),
        tagDeleteButtonBackgroundColor: .white.opacity(0.1)
    )
}

struct LightColorTheme: Theme {
    let id: String = "LightColor"
    let fontColor: Color = Color("BaseFontLight")
    let borderButtonColor: Color = Color("Light")
    let borderColor: Color = Color("LightBrawn")
    let textFieldColor: TextFieldColor = TextFieldColor(
        textBackgroundColor: Color("Light"),
        textFieldIconColor: Color("Brawn")
    )
    let resetButtonColor: ResetButtonColor = ResetButtonColor(
        resetButtonFontColor: Color("BaseFontLight"),
        resetButtonBackground: Color("LightBrawn")
    )
    let registerButtonColor: RegisterButtonColor = RegisterButtonColor(
        registerButtonBackgroundColor: Color("PastelLightBlue"),
        registerButtonFontColor: Color("Light")
    )
    let tagColor: TagColor = TagColor(
        tagBackground: Color("LightTagBackground"),
        tagSelectBackground: Color("LightSelectTagBackground"),
        tagDeleteButtonBackgroundColor: Color("LightDeleteTagBackground")
    )
}

struct Component {
    let borderColor: Color
    let compBackground: Color
    let compSelectBackground: Color
    let colorSelectButtonBackgrond: Color
    let buttonBackground: Color
    let buttonBlueBackground: Color
    let buttonPurpleBackground: Color
    let buttonBorder: Color
    let textFieldBorder: Color
    let selectedTabColor: Color
    let defaultTabColor: Color
    let toastBackgroundColor: Color
    let blueToastBackgroundColor: Color
    let errorToastBackgroundColor: Color
    let imageCardBorder: Color
}

struct Base {
    let BaseBackground: Color
    let baseFontColor: Color
    let redFontColor: Color
    let greenFontColor: Color
    let blueFontColor: Color
}

struct ExtendedColors {
    let base: Base
    let component: Component
}

extension Color {
    static func rgba(r: Double, g: Double, b: Double, a: Double = 1.0) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255, opacity: a)
    }

    static let extendedColors: ExtendedColors = ExtendedColors(
        base: Base(
            BaseBackground: Color.rgba(r: 40, g: 42, b: 65),
            baseFontColor: Color.rgba(r: 223, g: 226, b: 232),
            redFontColor: Color.rgba(r: 221, g: 118, b: 124),
            greenFontColor: Color.rgba(r: 141, g: 231, b: 167),
            blueFontColor: Color.rgba(r: 132, g: 137, b: 221),
        ),
        component: Component(
            borderColor: Color.rgba(r: 65, g: 61, b: 115),
            compBackground: Color.rgba(r: 26, g: 21, b: 59),
            compSelectBackground: Color.rgba(r: 46, g: 60, b: 140),
            colorSelectButtonBackgrond: Color.rgba(r: 46, g: 72, b: 160),
            buttonBackground: Color.rgba(r: 40, g: 42, b: 65),
            buttonBlueBackground: Color.rgba(r: 46, g: 72, b: 160),
            buttonPurpleBackground: Color.rgba(r: 88, g: 82, b: 228),
            buttonBorder: Color.rgba(r: 159, g: 167, b: 202),
            textFieldBorder: Color.rgba(r: 186, g: 197, b: 228),
            selectedTabColor: Color.rgba(r: 152, g: 173, b: 253),
            defaultTabColor: Color.rgba(r: 105, g: 94, b: 154),
            toastBackgroundColor: Color.rgba(r: 66, g: 210, b: 147),
            blueToastBackgroundColor: Color.rgba(r: 0, g: 131, b: 246),
            errorToastBackgroundColor: Color.rgba(r: 255, g: 72, b: 82),
            imageCardBorder: Color.rgba(r: 229, g: 231, b: 239)
        ),
    )

}
