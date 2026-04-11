import SwiftUI
import UIKit

struct EditFavoriteColorScreen: View {
    // FavoriteScreenからの受け渡し値
    @State var selectedColor: ColorData
    @State var red: String
    @State var green: String
    @State var blue: String
    @State var redSlider: Double
    @State var greenSlider: Double
    @State var blueSlider: Double
    @State var color: Color = .white
    @State var opacity: Float = 1.0
    @State var isShowToastType: ToastType?
    @State var memoText: String = ""
    @State var tagSelectedIndex: String = ""
    @State var tagData: [Tag] = []
    @State var checkerType: ColorCheckerType = .Input
    @State var isResetting: Bool = false
    @EnvironmentObject var appSettitngs: AppSettings
    
    let reposiroty: FavoriteColorRepository = FavoriteColorRepositoryImpl()
    let tagReposiroty: TagRepository = TagRepositoryImpl()
    
    init(selectedColor: ColorData) {
        self._selectedColor = State(initialValue: selectedColor)
        // RGB を文字列で初期化
        self._red = State(initialValue: String(selectedColor.red))
        self._green = State(initialValue: String(selectedColor.green))
        self._blue = State(initialValue: String(selectedColor.blue))
        // Slider
        self._redSlider = State(initialValue: Double(selectedColor.red))
        self._greenSlider = State(initialValue: Double(selectedColor.green))
        self._blueSlider = State(initialValue: Double(selectedColor.blue))
        self._tagSelectedIndex = State(initialValue: String(selectedColor.tagId))
        
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
        return (value * 100).rounded() / 100
    }
    
    private func RGBtoColor() -> Color {
        let calcR = clampTo255(colorNum: red)
        let calcG = clampTo255(colorNum: green)
        let calcB = clampTo255(colorNum: blue)
        return Color.rgba(r: Double(calcR), g: Double(calcG), b: Double(calcB), a: Double(opacity))
    }
    private func RGBtoColor(r: Double, g: Double, b: Double) -> Color {
        return Color.rgba(r: r, g: g, b: b, a: Double(opacity))
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
        let saveColorData: ColorData
        if checkerType == .Input {
            saveColorData = ColorData(id: selectedColor.id, red: clampTo255(colorNum: red), green: clampTo255(colorNum: green), blue: clampTo255(colorNum: blue), alpha: rounded2(value: opacity), hexColor: RGBtoHex(), memo: memoText, tagId: tagSelectedIndex)
            
        } else {
            saveColorData = ColorData(id: selectedColor.id, red: Int(redSlider), green: Int(greenSlider), blue: Int(blueSlider), alpha: rounded2(value: opacity), hexColor: RGBtoHex(), memo: memoText, tagId: tagSelectedIndex)
            
        }
        if let index = colorsData.firstIndex(where: { $0.id == selectedColor.id }) {
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
        ScrollView {
            ZStack {
                VStack(spacing: 8) {
                    Picker("Screentype", selection: $checkerType) {
                        Text("Input")
                            .tag(ColorCheckerType.Input)
                        Text("Slider")
                            .tag(ColorCheckerType.Slider)
                    }
                    .pickerStyle(.segmented)
                    if checkerType == .Input {
                        RGBRow(red: $red, green: $green, blue: $blue, isShowToastType: $isShowToastType,
                               borderColor: appSettitngs.themeColor.stringValue.borderColor, background: appSettitngs.themeColor.stringValue.textFieldColor.textBackgroundColor
                        )
                        .padding(.top, 12)
                    } else if checkerType == .Slider {
                        VStack {
                            SliderView(redSlider: $redSlider, greenSlider: $greenSlider, blueSlider: $blueSlider)
                            
                        }
                        .onChange(of: [redSlider, greenSlider, blueSlider]) { _ in
                            // isResettingがtrueの際に呼び出される
                            guard !isResetting else {
                                isResetting = false
                                return
                            }
                            print("isResetting \(isResetting)")
                            print("red: \(redSlider) green: \(greenSlider) blue: \(blueSlider)")
                            self.color = RGBtoColor(r: redSlider, g: greenSlider, b: blueSlider)
                        }
                    }
                    ColorArea(color: $color, height: 180)
                    VStack {
                        BaseTextField(inputString: $memoText, width: .infinity, height: 0, type: .imageTextField, image: Image(systemName: "bubble.left"), borderColor: appSettitngs.themeColor.stringValue.borderColor, backgroundColor: appSettitngs.themeColor.stringValue.textFieldColor.textBackgroundColor)
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(tagData) { tag in
                                        TagView(
                                            isSelectedIndex: $tagSelectedIndex,
                                            index: tag.id,
                                            text: tag.tagName,
                                            tagDeleteBackground: appSettitngs.themeColor.stringValue.tagColor.tagDeleteButtonBackgroundColor,
                                            background: appSettitngs.themeColor.stringValue.tagColor.tagBackground,
                                            selectedBackground: appSettitngs.themeColor.stringValue.tagColor.tagSelectBackground,
                                            textFontColor: appSettitngs.themeColor.stringValue.fontColor,
                                            onTap: { tagSelectedIndex = tag.id },
                                            onDeleteTap: { tagReposiroty.delete(tag)
                                            tagData = tagReposiroty.readAll()
                                        })
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Text("A : \(String(format: "%.2f", opacity))")
                            .foregroundStyle(Color.extendedColors.base.baseFontColor)
                        Slider(value: $opacity, in: 0...1)
                            .onChange(of: opacity) { newValue in
                                opacity = rounded2(value: newValue)
                                color = RGBtoColor()
                            }
                    }
                    HStack {
                        BaseButton(text: "カラー表示", width: 360, bodyColor: Color.extendedColors.component.buttonBlueBackground, borderColor: appSettitngs.themeColor.stringValue.borderColor, fontColor: .white, onTap: {
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
                        BaseButton(text: "更新", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, borderColor: appSettitngs.themeColor.stringValue.borderButtonColor, fontColor: appSettitngs.themeColor.stringValue.fontColor, onTap: {
                            if checkerType == .Input {
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
                .onAppear {
                    tagData = tagReposiroty.readAll()
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
                    Image(appSettitngs.themeColor.stringValue.id)
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
        .background(
            Image(appSettitngs.themeColor.stringValue.id)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
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
        memo: "プレビュー用のメモ",
        tagId: ""
    )
    EditFavoriteColorScreen(selectedColor: selectedColorData)
        .environmentObject(appSetting)
}
