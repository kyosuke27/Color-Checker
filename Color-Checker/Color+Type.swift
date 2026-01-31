//
//  Color+Type.swift
//  Color-Checker
//
//  Created by kyosuke on 2026/01/31.
//

import Foundation
import SwiftUI

struct Component{
    
}

struct Base{
    let BaseBackground:Color
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
            BaseBackground: Color.rgba(r: 255, g: 255, b: 255)
        ),
        component:Component(),
    )
   
}
