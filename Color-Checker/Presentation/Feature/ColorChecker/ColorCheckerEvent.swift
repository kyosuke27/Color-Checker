import Foundation

enum ColorCheckerEvent {
    // 画面表示
    case onAppear
    // 色変更
    case changeColor(ColorSettingType, Int)
    // 透明度変更
    case changeOpacity(Double)
    // メモ入力
    case changeMemoText(String)
    // 全ての色をクリアにする
    case clearAll
    // タグ入力用のモーダル
    case changeTagModal
    // タグ入力
    case changeTagText(String)
    // タグを削除する
    case deleteTag(Tag)
    // タグを選択
    case selectTagId(String)
    // 入力タイプの変更
    case changePickerType(ColorCheckerType)
    // トーストを変更する
    case changeToastType(ToastType?)
    // 保存処理
    case saveData
    // タグを保存する
    case saveTag
}
