import Foundation

enum ColorCheckerEvent {
    case showColor
    // 色変更
    case changeColor(ColorSettingType, String)
    // 透明度変更
    case changeOpacity(Double)
    // メモ入力
    case changeMemoText(String)
    // 全ての色をクリアにする
    case clearAll
    // 保存処理
    case saveData
}
