import SwiftUI

struct RGBRow: View {
    @Binding var red: String
    @Binding var green: String
    @Binding var blue: String
    @Binding var isShowToastType: ToastType?
    let borderColor: Color
    let background: Color
    let rgbRowBackground: Color

    var body: some View {
        HStack {
            RGBInput(text: $red, labelString: "R", fontColor: Color.extendedColors.base.redFontColor, borderColor: borderColor, backgroundColor: background)
            Spacer()
            RGBInput(text: $green, labelString: "G", fontColor: Color.extendedColors.base.greenFontColor, borderColor: borderColor, backgroundColor: background)
            Spacer()
            RGBInput(text: $blue, labelString: "B", fontColor: Color.extendedColors.base.blueFontColor, borderColor: borderColor, backgroundColor: background)
            Spacer()
            Button {
                UIPasteboard.general.string = "\(red),\(green),\(blue)"
                isShowToastType = .copySuccess
                Task {
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                    self.isShowToastType = nil
                }
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
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(rgbRowBackground)
                .shadow(color: borderColor.opacity(0.8), radius: 3, x: 3, y: 3)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.extendedColors.component.textFieldBorder.opacity(0.2))
        }
    }
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var red = "255"
    @State private var green = "255"
    @State private var blue = "255"
    @State private var isShowToastType: ToastType?
    let borderColor: Color = .black
    let backgtound: Color = .black

    var body: some View {
        RGBRow(
            red: $red,
            green: $green,
            blue: $blue,
            isShowToastType: $isShowToastType,
            borderColor: borderColor,
            background: backgtound,
            rgbRowBackground: .black
        )
        .padding()
        .background(Color.black) // 背景が必要なら
    }
}
