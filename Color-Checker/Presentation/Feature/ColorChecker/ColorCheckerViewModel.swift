import Foundation
import Combine
import SwiftUI

class ColorCheckerViewModel: ObservableObject {
    @Published var state: ColorCheckerState
    // viewModel
    let interstitialViewModel: InterstitialViewModel
    // reposiroty
    let favoriteColorRepository: FavoriteColorRepository = FavoriteColorRepositoryImpl()
    let tagRepository: TagRepository = TagRepositoryImpl()
    // log const
    private let TAG: String = "ColorCheckerViewModel"

    init(interStitialViewModel: InterstitialViewModel) {
        self.state = ColorCheckerState(
            red: 0,
            green: 0,
            blue: 0,
            opacity: 1.0,
            memoText: "",
            toastType: nil,
            colorCheckerType: .Slider,
            isTagModal: false,
            tagName: "",
            tagsData: [],
            isSelectedTagId: "",
        )
        self.interstitialViewModel = interStitialViewModel
    }
    
    func onEvent(event: ColorCheckerEvent) {
        switch event {
        case .onAppear:
            onAppear()

        case .clearAll:
            clearAll()
            
        case let .changeColor(colorSettingType, value):
            changeColor(type: colorSettingType, value: value)

        case let .changeMemoText(text):
            changeMemoText(text: text)

        case let .changeOpacity(value):
            changeOpacity(value: value)
        
        case let .changeToastType(type):
            changeToastType(type: type)
        
        case .changeTagModal:
            changeShowTagModal()
        
        case let .changeTagText(text):
            changeTagNameText(tagNameText: text)

        case let .selectTagId(tagId):
            selectedTagId(tagId: tagId)

        case let .changePickerType(type):
            changePickerType(type: type)

        case .saveData:
            saveColor()

        case .saveTag:
            saveTag()

        case let .deleteTag(tag):
            deleteTag(tag: tag)
        }
        
    }
    
    // MARK: Event Function
    
    private func onAppear() {
        state.tagsData = tagRepository.readAll()
    }
    
    private func changeColor(type: ColorSettingType, value: Int) {
            switch type {
            case .red:
                state.red = value
                
            case .green:
                state.green = value
                
            case .blue:
                state.blue = value
            }
        }
    
    private func changeMemoText(text: String) {
        state.memoText = text
    }
    
    private func changeToastType(type: ToastType?) {
        state.toastType = type
    }
    
    private func changeTagNameText(tagNameText: String) {
        state.tagName = tagNameText
    }
    
    private func changeShowTagModal() {
        state.isTagModal.toggle()
    }
    
    private func selectedTagId(tagId: String) {
        state.isSelectedTagId = tagId
    }
    
    private func changePickerType(type: ColorCheckerType) {
        state.colorCheckerType = type
    }
    
    private func clearAll() {
        state.red = 0
        state.green = 0
        state.blue = 0
        state.opacity = 0.5
        state.memoText = ""
    }
        
        private func changeOpacity(value: Double) {
            state.opacity = value
        }
        
        private func RGBtoHex(r: Int, g: Int, b: Int) -> String {
            // 2桁の16進数表記にする
            // %: フォーマット指定
            // 0: 0埋め
            // 2: 2桁
            // X: 16進数表記にする
            return String(format: "%02X%02X%02X", r, g, b)
        }
        
        // 少数第二位の値を返す
        private func rounded2(value: Double) -> Float {
            return Float((value * 100).rounded() / 100)
        }
        
        // 文字列の数字を0~255の数値に変換
        // 空文字の場合には255を返す
        // Intに変換できないときには0を返す
        private func clampTo255(colorNum: Int) -> Int {
            // 空の場合初期化後なので、255を返す
            if colorNum > 255 {
                return 255
            }
            if colorNum < 0 {
                return 0
            }
            return colorNum
        }
    
        // RGBAを入力してColorを返す
        private func RGBtoColor(red: Int, green: Int, blue: Int, opacity: Double) -> Color {
            let calcR = clampTo255(colorNum: red)
            let calcG = clampTo255(colorNum: green)
            let calcB = clampTo255(colorNum: blue)
            return Color.rgba(r: Double(calcR), g: Double(calcG), b: Double(calcB), a: Double(opacity))
        }
        
        // 16進数を返す
        private func RGBtoHex(red: Int, green: Int, blue: Int, opacity: Double) -> String {
            let calcR = clampTo255(colorNum: red)
            let calcG = clampTo255(colorNum: green)
            let calcB = clampTo255(colorNum: blue)
            // 2桁の16進数表記にする
            // %: フォーマット指定
            // 0: 0埋め
            // 2: 2桁
            // X: 16進数表記にする
            return String(format: "%02X%02X%02X", calcR, calcG, calcB)
            
        }
        private func clearState() {
            state.red = 0
            state.green = 0
            state.blue = 0
            state.memoText = ""
        }
        
        // MARK: エラーチェック
    
        // 入力されたRGBチェック
        private func checkRGB(red: Int, green: Int, blue: Int) -> String? {
            let UPPER_LIMIT = 255
            let LOWER_LIMIT = 0
            if  state.red > UPPER_LIMIT || state.green > UPPER_LIMIT || state.blue > UPPER_LIMIT {
                let message = "入力値は255以下にしてください。"
                return message
            }
            if state.red < LOWER_LIMIT || state.green < LOWER_LIMIT || state.blue < LOWER_LIMIT {
                let message = "入力値は0以上にしてください。"
                return message
            }
            
            return nil
        }
    
        // メッセージの長さをチェック
        private func checkMessageLimit(messageText: String) -> String? {
            let MESSAGE_LIMIT = 20
            
            if state.memoText.count > MESSAGE_LIMIT {
                let message = "入力値は20文字以下にしてください。"
                return message
            }
            return nil
        }
    
    private func delayChangeToastNil() {
        Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            changeToastType(type: nil)
        }
    }
    
    private func saveColor() {
        // RGB範囲チェック
        if let valid = checkRGB(red: state.red, green: state.green, blue: state.blue) {
            state.toastType = .error(valid)
            delayChangeToastNil()
            return
        }
        // メッセージの長さをチェック
        if let valid = checkMessageLimit(messageText: state.memoText) {
            state.toastType = .error(valid)
            delayChangeToastNil()
            return
        }
        var colorsData = favoriteColorRepository.getColor()
        // Add New Favorite Data
        let saveColorData = ColorData(
            id: UUID().uuidString,
            red: clampTo255(colorNum: state.red),
            green: clampTo255(colorNum: state.green),
            blue: clampTo255(colorNum: state.blue),
            alpha: rounded2(value: state.opacity),
            hexColor: RGBtoHex(r: state.red, g: state.green, b: state.blue),
            memo: state.memoText,
            tagId: state.isSelectedTagId
        )
        colorsData.append(saveColorData)
        // Save Favorite Colors Data
        favoriteColorRepository.saveColor(colorsData)
        state.toastType = .success
        delayChangeToastNil()
        self.interstitialViewModel.showAd()
    }
    
    private func saveTag() {
        if state.tagName.isEmpty {
            return
        }
        // Create Tag
        let tag = Tag(id: UUID().uuidString, tagName: state.tagName)
        state.tagsData.append(tag)
        print("state.tagsData \(state.tagsData)")
        tagRepository.save(state.tagsData)
        state.tagsData = tagRepository.readAll()
    }
    
    private func deleteTag(tag: Tag?) {
        guard let deleteTag = tag else {
            return
        }
        tagRepository.delete(deleteTag)
        state.tagsData = tagRepository.readAll()
    }
}
