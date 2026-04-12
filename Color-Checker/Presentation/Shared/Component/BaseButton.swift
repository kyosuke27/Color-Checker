import SwiftUI

struct BaseButton: View {
    let cornerAmount: CGFloat = 10
    let text: String
    let width: CGFloat
    let bodyColor: Color
    let borderColor: Color
    let fontColor: Color
    let onTap: () -> Void
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(text)
                .frame(width: width, height: 40)
                .foregroundStyle(fontColor)
            // ボタンの背景
                .background(
                    RoundedRectangle(cornerRadius: cornerAmount)
                        .fill(bodyColor)
                        .shadow(color: borderColor.opacity(0.8), radius: 2, x: 2, y: 2)
                )
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerAmount).stroke(borderColor, lineWidth: 1)
        )
    }
}

#Preview {
    VStack {
        HStack {
            BaseButton(text: "←", width: 50, bodyColor: Color.extendedColors.component.buttonBackground, borderColor: .white, fontColor: .white, onTap: {})
            BaseButton(text: "↑", width: 50, bodyColor: Color.extendedColors.component.buttonBackground, borderColor: .white, fontColor: .white, onTap: {})
            BaseButton(text: "↓", width: 50, bodyColor: Color.extendedColors.component.buttonBackground, borderColor: .white, fontColor: .white, onTap: {})
            BaseButton(text: "→", width: 50, bodyColor: Color.extendedColors.component.buttonBackground, borderColor: .white, fontColor: .white, onTap: {})
        }
        BaseButton(text: "カラー選択", width: 200, bodyColor: Color.extendedColors.component.colorSelectButtonBackgrond, borderColor: .white, fontColor: .white, onTap: {})
    }
}
