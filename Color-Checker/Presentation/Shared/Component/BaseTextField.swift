import SwiftUI

struct BaseTextField: View {
    @Binding var inputString: String
    let width: CGFloat
    let height: CGFloat
    let type: InputType
    let image: Image?

    init(
        inputString: Binding<String>,
        width: CGFloat,
        height: CGFloat,
        type: InputType,
        image: Image? = nil
    ) {
        self._inputString = inputString
        self.width = width
        self.height = height
        self.type = type
        self.image = image
    }

    var body: some View {
        switch type {
        case .defaultTextInput:
            defaultTextField()
        case .numberInput:
            numberTextField()
        case .imageTextField:
            imageTextField()

        }

    }

    private func defaultTextField() -> some View {
        return ZStack {
            TextField("0", text: $inputString, prompt: Text("0").foregroundStyle(Color.extendedColors.base.baseFontColor.opacity(0.1)))
                .frame(width: width, height: height)
                .padding(8)
                .background(Color.extendedColors.base.BaseBackground.opacity(0.9))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color.extendedColors.component.textFieldBorder, lineWidth: 1)
                )
                .keyboardType(.default)
                .submitLabel(.done)
                .multilineTextAlignment(TextAlignment.center)
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
                .font(.system(size: 18))

        }

    }
    private func numberTextField() -> some View {
        return ZStack {
            TextField("0", text: $inputString, prompt: Text("0").foregroundStyle(Color.extendedColors.base.baseFontColor.opacity(0.1)))
                .frame(width: width, height: height)
                .padding(8)
                .background(Color.extendedColors.base.BaseBackground.opacity(0.9))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color.extendedColors.component.textFieldBorder, lineWidth: 1)
                )
                .keyboardType(.numberPad)
                .submitLabel(.done)
                .multilineTextAlignment(TextAlignment.center)
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
                .font(.system(size: 18))

        }
    }
    private func imageTextField() -> some View {
        return ZStack {
            HStack {
                image?
                    .resizable()
                    .frame(width: 24, height: 24)
                TextField("0", text: $inputString, prompt: Text("0").foregroundStyle(Color.extendedColors.base.baseFontColor.opacity(0.1)))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .keyboardType(.default)
                    .submitLabel(.done)
                    .multilineTextAlignment(TextAlignment.center)
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
            }
            .padding(8)
            .background(Color.extendedColors.base.BaseBackground.opacity(0.9))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.extendedColors.component.textFieldBorder, lineWidth: 1)
            )

        }
    }
}

#Preview {
    @Previewable @State var inputString = ""
    VStack {
        BaseTextField(inputString: $inputString, width: 100, height: 50, type: .defaultTextInput)
        BaseTextField(inputString: $inputString, width: 200, height: 80, type: .numberInput)
        BaseTextField(inputString: $inputString, width: 200, height: 80, type: .imageTextField, image: Image(systemName: "bubble.left"))
    }
    .padding()
}
