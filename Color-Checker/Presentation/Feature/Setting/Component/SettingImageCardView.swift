import SwiftUI

struct SettingImageCardView: View {
    let selectedSetingImagType: SettingImageType
    let settingImageType: SettingImageType
    let side: CGFloat
    let onTap: () -> Void

    var isCheck: Bool { selectedSetingImagType.rawValue == settingImageType.rawValue}

    var body: some View {
        Image(settingImageType.stringValue.id)
            .resizable()
            .frame(width: side, height: side)
            .cornerRadius(8)
            .overlay(
                Group {
                    if isCheck {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.extendedColors.component.selectedTabColor, lineWidth: 2)
                    } else {
                        Color.clear.opacity(0)
                    }
                }
            )
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                onTap()
            }
    }
}

#Preview {
    HStack {
        ForEach(SettingImageType.allCases, id: \.rawValue) { setting in
            SettingImageCardView(selectedSetingImagType: SettingImageType.defaultImage, settingImageType: setting, side: 45, onTap: {})
        }
    }
}
