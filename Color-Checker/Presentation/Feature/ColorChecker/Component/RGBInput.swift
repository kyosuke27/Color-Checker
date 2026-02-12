import SwiftUI

struct RGBInput: View {
    @Binding var text: String
    let labelString: String
    let fontColor: Color

    var body: some View {
        HStack {
            Text(labelString)
                .font(.system(size: 24))
                .padding(.trailing, 8)
                .foregroundStyle(fontColor)
            BaseTextField(inputString: $text, width: 45, height: 18)
        }
    }
}

#Preview {
    @Previewable @State var inputString1 = "255"
    @Previewable @State var inputString2 = "255"
    @Previewable @State var inputString3 = "255"
    RGBInput(text: $inputString1, labelString: "R", fontColor: Color.extendedColors.base.redFontColor)
    RGBInput(text: $inputString2, labelString: "G", fontColor: Color.extendedColors.base.greenFontColor)
    RGBInput(text: $inputString3, labelString: "B", fontColor: Color.extendedColors.base.blueFontColor)
}
