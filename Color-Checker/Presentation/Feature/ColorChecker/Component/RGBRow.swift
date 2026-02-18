import SwiftUI

struct RGBRow: View {
    @Binding var red: String
    @Binding var green: String
    @Binding var blue: String

    var body: some View {
        HStack {
            RGBInput(text: $red, labelString: "R", fontColor: Color.extendedColors.base.redFontColor)
            Spacer()
            RGBInput(text: $green, labelString: "G", fontColor: Color.extendedColors.base.greenFontColor)
            Spacer()
            RGBInput(text: $blue, labelString: "B", fontColor: Color.extendedColors.base.blueFontColor)
            Spacer()
            Button {
                UIPasteboard.general.string = "\(red),\(green),\(blue)"
            } label: {
                Image(systemName: "list.clipboard.fill")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundStyle(.white)
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.extendedColors.base.BaseBackground)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.extendedColors.component.textFieldBorder.opacity(0.2))
        }
    }
}

#Preview {
    @Previewable @State var red = ""
    @Previewable @State var green = ""
    @Previewable @State var blue = ""
    RGBRow(red: $red, green: $green, blue: $blue)
}
