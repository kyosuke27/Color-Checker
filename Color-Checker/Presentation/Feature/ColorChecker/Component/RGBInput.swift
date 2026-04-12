import SwiftUI

struct RGBInput: View {
    @Binding var text: String
    let labelString: String
    let fontColor: Color
    let borderColor: Color
    let backgroundColor: Color

    var body: some View {
        HStack {
            Text(labelString)
                .font(.system(size: 24))
                .padding(.trailing, 8)
                .foregroundStyle(fontColor)
            BaseTextField(
                inputString: $text,
                width: 45,
                height: 18,
                type: .numberInput,
                borderColor: borderColor,
                backgroundColor: backgroundColor,
                fontColor: fontColor
            )
        }
    }
}

#Preview {
    PreviewContainer()
}
private struct PreviewContainer: View {
    @State private var inputString1 = "255"
    @State private var inputString2 = "255"
    @State private var inputString3 = "255"
    let borderColor: Color = .black
    let backgroundColor: Color = .black

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RGBInput(text: $inputString1, labelString: "R", fontColor: Color.extendedColors.base.redFontColor, borderColor: borderColor, backgroundColor: backgroundColor)
            RGBInput(text: $inputString2, labelString: "G", fontColor: Color.extendedColors.base.greenFontColor, borderColor: borderColor, backgroundColor: backgroundColor)
            RGBInput(text: $inputString3, labelString: "B", fontColor: Color.extendedColors.base.blueFontColor, borderColor: borderColor, backgroundColor: backgroundColor)
        }
        .padding()
    }
}
