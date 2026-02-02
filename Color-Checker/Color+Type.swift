import Foundation
import SwiftUI

struct Component{
    let colorSelectButtonBackgrond:Color
    let buttonBackground:Color
    let buttonBlueBackground:Color
    let buttonBorder:Color
    let textFieldBorder:Color
}

struct Base{
    let BaseBackground:Color
    let baseFontColor:Color
    let redFontColor:Color
    let greenFontColor:Color
    let blueFontColor:Color
}

struct ExtendedColors{
    let base:Base
    let component:Component
}

extension Color{
    static func rgba(r:Double,g:Double,b:Double,a:Double = 1.0)->Color{
        return Color(red:r/255,green:g/255,blue:b/255,opacity:a)
    }
    
    
    static let extendedColors:ExtendedColors = ExtendedColors(
        base:Base(
            BaseBackground: Color.rgba(r: 40, g: 42, b: 65),
            baseFontColor: Color.rgba(r: 223, g: 226, b: 232),
            redFontColor: Color.rgba(r: 221, g: 118, b: 124),
            greenFontColor: Color.rgba(r: 141, g: 231, b: 167),
            blueFontColor: Color.rgba(r: 132, g: 137, b: 221),
        ),
        component:Component(
            colorSelectButtonBackgrond: Color.rgba(r: 46, g: 72, b: 160),
            buttonBackground: Color.rgba(r: 40, g: 42, b: 65),
            buttonBlueBackground: Color.rgba(r: 46, g: 72, b: 160),
            buttonBorder: Color.rgba(r: 159, g: 167, b: 202),
            textFieldBorder: Color.rgba(r: 186, g: 197, b: 228)
        ),
    )
   
}
