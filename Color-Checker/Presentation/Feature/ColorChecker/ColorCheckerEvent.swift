import Foundation

enum ColorCheckerEvent {
    // 色変更
    case changeColor(ColorSettingType, Int)
    // 透明度変更
    case changeOpacity(Double)
    // メモ入力
    case changeMemoText(String)
    // 全ての色をクリアにする
    case clearAll
    // トーストを変更する
    case changeToastType(ToastType?)
    // 保存処理
    case saveData
    // タグを保存する
    case saveTag
}
