import SwiftUI

struct BaseButton: View {
    let cornerAmount:CGFloat = 10
    let text:String
    let width:CGFloat
    let bodyColor:Color
    let onTap:()->Void
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(text)
                .frame(width:width,height: 40)
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
            // ボタンの背景
                .background(
                    RoundedRectangle(cornerRadius: cornerAmount).fill(bodyColor)
                )
            // 枠線を上に重ねる
            // 背景の上に重ねる
                .overlay(
                    RoundedRectangle(cornerRadius: cornerAmount).stroke(Color.extendedColors.component.buttonBorder.opacity(0.8),lineWidth: 1)
                )
        }
    }
}

#Preview {
    VStack{
        HStack{
            BaseButton(text:"←",width:50,bodyColor:Color.extendedColors.component.buttonBackground,onTap: {})
            BaseButton(text:"↑",width:50,bodyColor:Color.extendedColors.component.buttonBackground,onTap: {})
            BaseButton(text:"↓",width:50,bodyColor:Color.extendedColors.component.buttonBackground,onTap: {})
            BaseButton(text:"→",width:50,bodyColor:Color.extendedColors.component.buttonBackground,onTap: {})
        }
        BaseButton(text:"カラー選択",width:200,bodyColor:Color.extendedColors.component.colorSelectButtonBackgrond,onTap: {})
    }
}
