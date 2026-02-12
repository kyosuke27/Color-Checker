import SwiftUI

struct ColorCheckerScreen: View {
    @State var red: String = ""
    @State var green: String = ""
    @State var blue: String = ""
    @State var color: Color = .white
    @State var opacity: Double = 1.0
    let reposiroty: FavoriteColorRepository = FavoriteColorRepositoryImpl()

    private func rounded2String(value: Double) -> String {
        return String((value*100).rounded()/100)
    }

    private func RGBtoColor() -> Color {
        let calcR = clampTo255(colorNum: red)
        let calcG = clampTo255(colorNum: green)
        let calcB = clampTo255(colorNum: blue)
        return Color.rgba(r: Double(calcR), g: Double(calcG), b: Double(calcB))
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
        return String(format: "#%02X%02X%02X", calcR, calcG, calcB)

    }

    // 0~255に変換
    private func clampTo255(colorNum: String) -> Int {
        let minLimtValue = 0
        let maxValue = 255
        return min(max((Int(colorNum) ?? 0), minLimtValue), maxValue)
    }

    private func saveColor() {
        // Get Favorite Colors Data
        var colorsData: [ColorData] = reposiroty.getColor()
        // Add New Favorite Data
        let saveColorData: ColorData = ColorData(red: clampTo255(colorNum: red), green: clampTo255(colorNum: green), blue: clampTo255(colorNum: blue), hexColor: RGBtoHex())
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

    var body: some View {
        VStack(spacing: 16) {
            Text("Color Checker")
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
                .font(.system(size: 38))
                .padding()
            RGBRow(red: $red, green: $green, blue: $blue )
            ColorArea(color: $color, height: 240)
            HStack {
                Text("A : \(rounded2String(value: opacity))")
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
                Slider(value: $opacity, in: 0...1)
                    .onChange(of: opacity) { _, newValue in
                        opacity = newValue
                        color = RGBtoColor()
                    }
            }
            HStack {
                BaseButton(text: "カラー表示", width: 180, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                    color = RGBtoColor()
                })
                BaseButton(text: "リセット", width: 180, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                    red = ""
                    green = ""
                    blue = ""
                    color = .white
                })
            }
            HStack {
                BaseButton(text: "保存", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, onTap: {
                    saveColor()
                })
            }

            Button {
                getColor()
            } label: {
                Text("Color get")
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .background(
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ColorCheckerScreen()
}
