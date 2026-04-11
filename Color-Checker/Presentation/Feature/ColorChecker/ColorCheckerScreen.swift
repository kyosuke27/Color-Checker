import SwiftUI
import UIKit
import GoogleMobileAds

struct ColorCheckerScreen: View {
    @EnvironmentObject var appSettitngs: AppSettings
    @EnvironmentObject var interstitialViewModel: InterstitialViewModel
    let onEvent: (ColorCheckerEvent) -> Void
    var state: ColorCheckerState
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 8) {
                    Picker("Screentype",
                           selection: Binding<ColorCheckerType>(
                            get: { state.colorCheckerType },
                            set: {newValue in
                                print("newValue \(newValue)")
                                onEvent(.changePickerType(newValue))
                            }
                           )
                    ) {
                        Image(systemName: "slider.horizontal.3")
                            .tag(ColorCheckerType.Slider)
                        Image(systemName: "numbers.rectangle")
                            .tag(ColorCheckerType.Input)
                    }
                    .background(.black)
                    .pickerStyle(.segmented)
                    .cornerRadius(16)
                    if state.colorCheckerType == .Input {
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
                            isShowToastType: Binding<ToastType?>(
                                get: { state.toastType },
                                set: {newValue in
                                    onEvent(.changeToastType(newValue))
                                }
                            ),
                            borderColor: appSettitngs.themeColor.stringValue.borderColor,
                            background: appSettitngs.themeColor.stringValue.textFieldColor.textBackgroundColor
                        )
                        .padding(.top, 12)
                    } else if state.colorCheckerType == .Slider {
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
                    }
                    ColorArea(
                        color:
                            Binding<Color>(
                                get: {
                                    state.color
                                },
                                set: {_ in
                                    
                                }
                            ), height: 180
                    )
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
                            width: .infinity,
                            height: 0,
                            type: .imageTextField,
                            image: Image(systemName: "bubble.left"),
                            imageColor: appSettitngs.themeColor.stringValue.textFieldColor.textFieldIconColor,
                            borderColor: appSettitngs.themeColor.stringValue.borderColor,
                            backgroundColor: appSettitngs.themeColor.stringValue.textFieldColor.textBackgroundColor
                        )
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(state.tagsData) { tag in
                                        TagView(
                                            isSelectedIndex: Binding<String>(
                                                get: { state.isSelectedTagId },
                                                set: { _ in }
                                            ),
                                            themeColor: appSettitngs.themeColor.stringValue,
                                            tag: tag,
                                            onTap: {
                                                onEvent(.selectTagId(tag.id))
                                            },
                                            onDeleteTap: {
                                                onEvent(.deleteTag(tag))
                                            },
                                        )
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            BaseButton(text: "＋", width: 40, bodyColor: Color.extendedColors.component.buttonBackground, borderColor: appSettitngs.themeColor.stringValue.borderButtonColor, fontColor: appSettitngs.themeColor.stringValue.registerButtonColor.registerButtonFontColor, onTap: {
                                onEvent(.changeTagModal)
                            })
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Text("A : \(String(format: "%.2f", state.opacity))")
                            .foregroundStyle(appSettitngs.themeColor.stringValue.fontColor)
                        Slider(value: Binding<Double>(
                            get: {
                                state.opacity
                            },
                            set: { newValue in
                                onEvent(.changeOpacity(newValue))
                            }
                        ), in: 0...1)
                    }
                    HStack {
                        BaseButton(
                            text: "リセット",
                            width: 360,
                            bodyColor: appSettitngs.themeColor.stringValue.resetButtonColor.resetButtonBackground,
                            borderColor: appSettitngs.themeColor.stringValue.borderColor,
                            fontColor: appSettitngs.themeColor.stringValue.resetButtonColor.resetButtonFontColor, onTap: {
                            onEvent(.clearAll)
                        })
                    }
                    HStack {
                        BaseButton(text: "保存", width: 360, bodyColor: appSettitngs.themeColor.stringValue.registerButtonColor.registerButtonBackgroundColor, borderColor: appSettitngs.themeColor.stringValue.borderButtonColor, fontColor: appSettitngs.themeColor.stringValue.registerButtonColor.registerButtonFontColor, onTap: {
                            onEvent(.saveData)
                        })
                    }
                    Spacer()
                }
                .onAppear {
                    onEvent(.onAppear)
                }
                .alert("タグ入力",
                       isPresented: Binding<Bool>(
                        get: { state.isTagModal },
                        set: { _ in onEvent(.changeTagModal) }
                       ),
                       actions: {
                    TextField("タグを入力",
                              text: Binding<String>(
                                get: {
                                    state.tagName
                                },
                                set: {newValue in
                                    onEvent(.changeTagText(newValue))
                                }
                              )
                    )
                    Button {
                        onEvent(.saveTag)
                        onEvent(.changeTagModal)
                    } label: {
                        Text("OK")
                    }
                    Button {
                        onEvent(.changeTagModal)
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
                if let type = state.toastType {
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
    let interstitialViewModel = InterstitialViewModel()
    let viewModel = ColorCheckerViewModel(interStitialViewModel: interstitialViewModel)
    ColorCheckerScreen(
        onEvent: { viewModel.onEvent(event: $0) },
        state: viewModel.state)
    .environmentObject(appSetting)
}
