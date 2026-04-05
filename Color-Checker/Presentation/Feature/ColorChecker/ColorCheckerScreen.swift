import SwiftUI
import UIKit
import GoogleMobileAds

struct ColorCheckerScreen: View {
    @State var red: String = ""
    @State var green: String = ""
    @State var blue: String = ""
    @State var redSldier: Double = 128
    @State var greenSlider: Double = 128
    @State var blueSlider: Double = 128
    @State var color: Color = .white
    @State var opacity: Float = 1.0
    @State var isShowToastType: ToastType?
    @State var memoText: String = ""
    @State var isSelectedIndex: String = ""
    @State var inputTagAlert: Bool = false
    @State var newTagText: String = ""
    @State var tagData: [Tag] = []
    @State var isResetting = false
    @State var checkerType: ColorCheckerType = .Slider
    @EnvironmentObject var appSettitngs: AppSettings
    @EnvironmentObject var interstitialViewModel: InterstitialViewModel
    let reposiroty: FavoriteColorRepository = FavoriteColorRepositoryImpl()
    let tagReposiroty: TagRepository = TagRepositoryImpl()
    let onEvent: (ColorCheckerEvent) -> Void
    var state: ColorCheckerState
    
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
    private func RGBtoHex(r: Int, g: Int, b: Int) -> String {
        // 2桁の16進数表記にする
        // %: フォーマット指定
        // 0: 0埋め
        // 2: 2桁
        // X: 16進数表記にする
        return String(format: "%02X%02X%02X", r, g, b)
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
        var saveColorData: ColorData
        // Add New Favorite Data
        if checkerType == .Input {
            saveColorData = ColorData(id: UUID().uuidString, red: clampTo255(colorNum: red), green: clampTo255(colorNum: green), blue: clampTo255(colorNum: blue), alpha: rounded2(value: opacity), hexColor: RGBtoHex(), memo: memoText, tagId: isSelectedIndex)
        } else {
            saveColorData = ColorData(id: UUID().uuidString, red: Int(redSldier), green: Int(greenSlider), blue: Int(blueSlider), alpha: rounded2(value: opacity), hexColor: RGBtoHex(r: Int(redSldier), g: Int(greenSlider), b: Int(blueSlider)), memo: memoText, tagId: isSelectedIndex)
        }
        colorsData.append(saveColorData)
        // Save Favorite Colors Data
        reposiroty.saveColor(colorsData)
        interstitialViewModel.showAd()
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
        if clampTo255(colorNum: red) > upperLimit || clampTo255(colorNum: green) > upperLimit || clampTo255(colorNum: blue) > upperLimit {
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
        isResetting = true
        self.red = ""
        self.green = ""
        self.blue = ""
        self.redSldier = 128
        self.greenSlider = 128
        self.blueSlider = 128
        self.memoText = ""
        self.newTagText = ""
        self.opacity = 1.0
        self.color = .white
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 8) {
                    Picker("Screentype", selection: $checkerType) {
                        Text("Slider")
                            .tag(ColorCheckerType.Slider)
                        Text("Input")
                            .tag(ColorCheckerType.Input)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: checkerType) { newValue in
                        print("newValue \(newValue)")
                    }
                    if checkerType == .Input {
                        RGBRow(
                            red: Binding<String>(
                                get: { String(state.red) },
                                set: { newValue in
                                    onEvent(.changeColor(.red, newValue.stringToInt()))
                                }
                            ),
                            green: Binding<String>(
                                get: { String(state.green) },
                                set: { newValue in
                                    onEvent(.changeColor(.green, newValue.stringToInt()))
                                }
                            ),
                            blue: Binding<String>(
                                get: { String(state.blue) },
                                set: { newValue in
                                    onEvent(.changeColor(.blue, newValue.stringToInt()))
                                }
                            ),
                            isShowToastType: $isShowToastType
                        )
                        .padding(.top, 12)
                    } else if checkerType == .Slider {
                        VStack {
                            SliderView(
                                redSlider: Binding<Double>(
                                    get: {
                                        state.red.intToDouble()
                                    },
                                    set: {newValue in
                                        onEvent(.changeColor(ColorSettingType.red, newValue.doubleToInt()))
                                    }
                                ),
                                greenSlider: Binding<Double>(
                                    get: {
                                        state.green.intToDouble()
                                    },
                                    set: {newValue in
                                        onEvent(.changeColor(ColorSettingType.green, newValue.doubleToInt()))
                                    }
                                ),
                                blueSlider: Binding<Double>(
                                    get: {
                                        state.blue.intToDouble()
                                    },
                                    set: {newValue in
                                        onEvent(.changeColor(ColorSettingType.blue, newValue.doubleToInt()))
                                    }
                                )
                            )
                            
                        }
                        .onChange(of: [redSldier, greenSlider, blueSlider]) { _ in
                            // isResettingがtrueの際に呼び出される
                            guard !isResetting else {
                                isResetting = false
                                return
                            }
                            print("isResetting \(isResetting)")
                            print("red: \(redSldier) green: \(greenSlider) blue: \(blueSlider)")
                            self.color = RGBtoColor(r: redSldier, g: greenSlider, b: blueSlider)
                        }
                    }
                    ColorArea(color: $color, height: 180)
                    VStack {
                        // メモ入力欄
                        BaseTextField(
                            inputString:
                                Binding<String>(
                                    get: {
                                        state.memoText
                                    },
                                    set: {newValue in
                                        onEvent(.changeMemoText(newValue))
                                    }
                                ),
                            width: .infinity, height: 0, type: .imageTextField, image: Image(systemName: "bubble.left"))
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(tagData) { tag in
                                        TagView(isSelectedIndex: $isSelectedIndex, index: tag.id, text: tag.tagName, onTap: { isSelectedIndex = tag.id }, onDeleteTap: {
                                            tagReposiroty.delete(tag)
                                            tagData = tagReposiroty.readAll()
                                        }
                                        )
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            BaseButton(text: "＋", width: 40, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                                inputTagAlert = true
                            })
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Text("A : \(String(format: "%.2f", opacity))")
                            .foregroundStyle(Color.extendedColors.base.baseFontColor)
                        Slider(value: Binding<Double>(
                            get: {
                                state.opacity
                            },
                            set: { newValue in
                                onEvent(.changeOpacity(newValue))
                            }
                        ), in: 0...1)
                            .onChange(of: opacity) { newValue in
                                opacity = rounded2(value: newValue)
                                color = RGBtoColor()
                                print("opacity change color \(color)")
                            }
                    }
                    HStack {
                        BaseButton(text: "カラー表示", width: 180, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                            if checkerType == .Input {
                                if let valid = isValidRGB(red: red, green: green, blue: blue) {
                                    self.isShowToastType = .error(valid)
                                    Task {
                                        try await Task.sleep(nanoseconds: 3_000_000_000)
                                        self.isShowToastType = nil
                                    }
                                    return
                                }
                            }
                            color = RGBtoColor()
                        })
                        BaseButton(text: "リセット", width: 180, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                            initialInput()
                            onEvent(.clearAll)
                        })
                    }
                    HStack {
                        BaseButton(text: "保存", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, onTap: {
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
            .onAppear {
                tagData = tagReposiroty.readAll()
                Task {
                    await interstitialViewModel.loadAd()
                }
            }
            .alert("タグ入力", isPresented: $inputTagAlert, actions: {
                TextField("タグを入力", text: $newTagText)
                Button {
                    if !newTagText.isEmpty {
                        let tag = Tag(id: UUID().uuidString, tagName: newTagText)
                        self.tagData.append(tag)
                        tagReposiroty.save(tagData)
                        self.tagData = tagReposiroty.readAll()
                    }
                } label: {
                    Text("OK")
                    
                }
                Button {
                } label: {
                    Text("Cancel")
                }
            })
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
            Image(appSettitngs.themeColor.stringValue)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
    
    extension ColorCheckerScreen {
        private var inputColorCheckerView: some View {
            return VStack {
                Text("")
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
        let viewModel = ColorCheckerViewModel()
        ColorCheckerScreen(
            onEvent: { viewModel.onEvent(event: $0) },
            state: viewModel.state)
        .environmentObject(appSetting)
    }
