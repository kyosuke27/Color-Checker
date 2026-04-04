import Foundation
import Combine
import SwiftUI

class ColorCheckerViewModel: ObservableObject {
    @Published var state: ColorCheckerState
    private let TAG: String = "ColorCheckerViewModel"
    
    init() {
        self.state = ColorCheckerState(red: 0, green: 0, blue: 0, opacity: 0, memoText: "")
    }
    
    func onEvent(event: ColorCheckerEvent) {
        switch event {
        case .showColor:
            print("hello")
            
        case .clearAll:
            print("hello")
            
        case let .changeColor(colorSettingType, value):
            updateColor(type: colorSettingType, value: value)
            
        case let .changeOpacity(value):
            changeOpacity(value: value)
        }
    }
        
        private func updateColor(type: ColorSettingType, value: String) {
            print("\(TAG) : 🟩start updateColor")
            switch type {
            case .red:
                state.red = stringToDouble(value: value)
                
            case .green:
                state.green = stringToDouble(value: value)
                
            case .blue:
                state.blue = stringToDouble(value: value)
            }
        }
        
        private func changeOpacity(value:Double){
            state.opacity = value
        }
        
        private func stringToDouble(value: String) -> Int {
            return Int(value) ?? 0
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
        private func rounded2(value: Float) -> Float {
            return (value * 100).rounded() / 100
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
    }
