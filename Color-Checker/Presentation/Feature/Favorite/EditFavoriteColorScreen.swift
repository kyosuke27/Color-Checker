import SwiftUI
import UIKit

struct EditFavoriteColorScreen: View {
    // FavoriteScreenからの受け渡し値
    @State var selectedColor: ColorData
    @State var red: String
    @State var green: String
    @State var blue: String
    @State var color: Color = .white
    @State var opacity: Float = 1.0
    @State var isShowToastType: ToastType?
    @State var memoText: String = ""
    @EnvironmentObject var appSettitngs: AppSettings
    let reposiroty: FavoriteColorRepository = FavoriteColorRepositoryImpl()

    init(selectedColor: ColorData) {
        self._selectedColor = State(initialValue: selectedColor)
        // RGB を文字列で初期化
        self._red = State(initialValue: String(selectedColor.red))
        self._green = State(initialValue: String(selectedColor.green))
        self._blue = State(initialValue: String(selectedColor.blue))

        // Color と opacity を初期化
        self._opacity = State(initialValue: selectedColor.alpha)
        self._color = State(initialValue:
                                Color.rgba(
                                    r: Double(selectedColor.red),
                                    g: Double(selectedColor.green),
                                    b: Double(selectedColor.blue),
                                    a: Double(selectedColor.alpha)
                                )
        )

        // メモを初期化
        self._memoText = State(initialValue: selectedColor.memo)
    }

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
        let minLimtValue = 0
        let maxValue = 255
        // 空の場合初期化後なので、255を返す
        if colorNum.isEmpty {
            return 255
        }
        return min(max((Int(colorNum) ?? 0), minLimtValue), maxValue)
    }

    private func updateColor() {
        // Get Favorite Colors Data
        var colorsData: [ColorData] = reposiroty.getColor()
        // Add New Favorite Data
        let saveColorData: ColorData = ColorData(id: UUID().uuidString, red: clampTo255(colorNum: red), green: clampTo255(colorNum: green), blue: clampTo255(colorNum: blue), alpha: rounded2(value: opacity), hexColor: RGBtoHex(), memo: memoText)
        if let index = colorsData.firstIndex(where: {$0.id == selectedColor.id}) {
            colorsData[index] = saveColorData
            reposiroty.saveColor(colorsData)
            return
        } else {
            return
        }
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
        let r = clampTo255(colorNum: red)
        let g = clampTo255(colorNum: green)
        let b = clampTo255(colorNum: blue)
        if r > upperLimit || g > upperLimit || b > upperLimit {
            return "入力値は255以下にしてください。"
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

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
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
                    BaseButton(text: "カラー表示", width: 360, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                        if let valid = isValidRGB(red: red, green: green, blue: blue) {
                            self.isShowToastType = .error(valid)
                            Task {
                                try await Task.sleep(nanoseconds: 3_000_000_000)
                                self.isShowToastType = nil
                            }
                            return
                        } else {
                            color = RGBtoColor()
                        }
                    })
                }
                HStack {
                    BaseButton(text: "更新", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, onTap: {
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
                        updateColor()
                        self.isShowToastType = .update
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

#Preview {
    let appSetting = AppSettings(id: "1234", themeColor: SettingImageType.blueColor)
    // 適当なダミーデータを用意
    let selectedColorData = ColorData(
        id: UUID().uuidString,
        red: 120,
        green: 180,
        blue: 240,
        alpha: 0.85,
        hexColor: "78B4F0",
        memo: "プレビュー用のメモ"
    )
    EditFavoriteColorScreen(selectedColor: selectedColorData)
        .environmentObject(appSetting)
}
