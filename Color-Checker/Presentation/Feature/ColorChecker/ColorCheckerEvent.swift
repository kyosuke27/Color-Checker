import Foundation

enum ColorCheckerEvent {
    case showColor
    // 色変更
    case changeColor(ColorSettingType, String)
    // 透明度変更
    case changeOpacity(Double)
    // 全ての色をクリアにする
    case clearAll
}
