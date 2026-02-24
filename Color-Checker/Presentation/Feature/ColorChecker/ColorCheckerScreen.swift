import SwiftUI
import UIKit

struct ColorCheckerScreen: View {
    @State var red: String = ""
    @State var green: String = ""
    @State var blue: String = ""
    @State var color: Color = .white
    @State var opacity: Float = 1.0
    @State var isShowToastType: ToastType?
    @State var memoText: String = ""
    @EnvironmentObject var appSettitngs: AppSettings
    let reposiroty: FavoriteColorRepository = FavoriteColorRepositoryImpl()

    private func rounded2(value: Float) -> Float {
        return (value*100).rounded()/100
    }

    private func RGBtoColor() -> Color {
        let calcR = clampTo255(colorNum: red)
        let calcG = clampTo255(colorNum: green)
        let calcB = clampTo255(colorNum: blue)
        return Color.rgba(r: Double(calcR), g: Double(calcG), b: Double(calcB), a: Double(opacity))
    }

    private func RGBtoHex() -> String {
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

    // 0~255に変換
    private func clampTo255(colorNum: String) -> Int {
        // 空の場合初期化後なので、255を返す
        if colorNum.isEmpty {
            return 255
        }
        return Int(colorNum) ?? 0
    }

    private func saveColor() {
        // Get Favorite Colors Data
        var colorsData: [ColorData] = reposiroty.getColor()
        // Add New Favorite Data
        let saveColorData: ColorData = ColorData(id: UUID().uuidString, red: clampTo255(colorNum: red), green: clampTo255(colorNum: green), blue: clampTo255(colorNum: blue), alpha: rounded2(value: opacity), hexColor: RGBtoHex(), memo: memoText)
        colorsData.append(saveColorData)
        // Save Favorite Colors Data
        reposiroty.saveColor(colorsData)
    }

    private func getColor() {
        let colorsData: [ColorData] = reposiroty.getColor()
        print("colorsData : \(colorsData)")
        colorsData.forEach { color in
            print(color)
        }
    }

    private func isValidRGB(red: String, green: String, blue: String) -> String? {
        let upperLimit = 255
        let downLimit = 0
        if clampTo255(colorNum: red)>upperLimit || clampTo255(colorNum: green)>upperLimit || clampTo255(colorNum: blue)>upperLimit {
            let message = "入力値は255以下にしてください。"
            return message
        }
        if clampTo255(colorNum: red) < downLimit || clampTo255(colorNum: green) < downLimit || clampTo255(colorNum: blue) < downLimit {
            let message = "入力値は0以上にしてください。"
            return message
        }

        return nil
    }

    private func isValidMessage(messageText: String) -> String? {
        let messageLimit = 20

        if memoText.count > messageLimit {
             let message = "入力値は20文字以下にしてください。"
            return message
        }
        return nil
    }

    private func initialInput() {
        self.red = ""
        self.green = ""
        self.blue = ""
        self.memoText = ""
        self.color = .white
    }

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Color Checker")
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
                    .font(.system(size: 38))
                    .padding()
                RGBRow(red: $red, green: $green, blue: $blue, isShowToastType: $isShowToastType )
                ColorArea(color: $color, height: 180)
                BaseTextField(inputString: $memoText, width: .infinity, height: 0, type: .imageTextField, image: Image(systemName: "bubble.left"))
                HStack {
                    Text("A : \(String(format: "%.2f", opacity))")
                        .foregroundStyle(Color.extendedColors.base.baseFontColor)
                    Slider(value: $opacity, in: 0...1)
                        .onChange(of: opacity) { _, newValue in
                            opacity = rounded2(value: newValue)
                            color = RGBtoColor()
                        }
                }
                HStack {
                    BaseButton(text: "カラー表示", width: 180, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                        if let valid = isValidRGB(red: red, green: green, blue: blue) {
                            self.isShowToastType = .error(valid)
                            Task {
                                try await Task.sleep(nanoseconds: 3_000_000_000)
                                self.isShowToastType = nil
                            }
                            return
                        }
                        color = RGBtoColor()
                    })
                    BaseButton(text: "リセット", width: 180, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                        initialInput()
                    })
                }
                HStack {
                    BaseButton(text: "保存", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, onTap: {
                        if let valid = isValidRGB(red: red, green: green, blue: blue) {
                            self.isShowToastType = .error(valid)
                            Task {
                                try await Task.sleep(nanoseconds: 3_000_000_000)
                                self.isShowToastType = nil
                            }
                            return
                        }
                        if let valid = isValidMessage(messageText: memoText) {
                            self.isShowToastType = .error(valid)
                            Task {
                                try await Task.sleep(nanoseconds: 3_000_000_000)
                                self.isShowToastType = nil
                            }
                            return
                        }
                        saveColor()
                        initialInput()
                        self.isShowToastType = .success
                        Task {
                            try await Task.sleep(nanoseconds: 3_000_000_000)
                            self.isShowToastType = nil
                        }
                    })
                }
                Spacer()

            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            UIApplication.shared.endEditing()
                        } label: {
                            Text("閉じる")
                        }

                    }
                }
            }
            .padding(.horizontal, 16)
            .background(
                Image(appSettitngs.themeColor.stringValue)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            if let type = isShowToastType {
                VStack {
                    ToastView(toastType: type)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

extension UIApplication {
    func endEditing(_ force: Bool = true) {
        self.sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil)
    }
}

#Preview {
    let appSetting = AppSettings(id: "1234", themeColor: SettingImageType.blueColor)
    ColorCheckerScreen()
        .environmentObject(appSetting)
}
