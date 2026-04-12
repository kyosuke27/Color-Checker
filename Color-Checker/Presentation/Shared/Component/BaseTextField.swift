import SwiftUI

struct BaseTextField: View {
    @Binding var inputString: String
    let width: CGFloat
    let height: CGFloat
    let type: InputType
    let image: Image?
    let imageColor: Color?
    let borderColor: Color
    let backgroundColor: Color
    let fontColor: Color
    
    init(
        inputString: Binding<String>,
        width: CGFloat,
        height: CGFloat,
        type: InputType,
        image: Image? = nil,
        imageColor: Color? = nil,
        borderColor: Color,
        backgroundColor: Color,
        fontColor: Color
    ) {
        self._inputString = inputString
        self.width = width
        self.height = height
        self.type = type
        self.image = image
        self.imageColor = imageColor
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
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
            TextField("メモを入力", text: $inputString, prompt: Text("メモを入力").foregroundColor(Color.extendedColors.base.baseFontColor.opacity(0.1)))
                .frame(width: width, height: height)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor.opacity(0.9))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1)
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
            TextField("0", text: $inputString, prompt: Text("0").foregroundColor(fontColor.opacity(0.1)))
                .frame(width: width, height: height)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor.opacity(0.9))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1)
                )
                .keyboardType(.numberPad)
                .submitLabel(.done)
                .multilineTextAlignment(TextAlignment.center)
                .foregroundStyle(fontColor)
                .font(.system(size: 18))
            
        }
    }
    private func imageTextField() -> some View {
        return ZStack {
            HStack {
                image?
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(self.imageColor ?? .red)
                TextField("メモを入力", text: $inputString, prompt: Text("メモを入力").foregroundColor(imageColor?.opacity(0.3)))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .keyboardType(.default)
                    .submitLabel(.done)
                    .multilineTextAlignment(TextAlignment.center)
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor.opacity(0.9))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
            
        }
    }
}

#Preview {
    BaseTextFieldContainer()
}

private struct BaseTextFieldContainer: View {
    @State var inputString = ""
    var body: some View {
        VStack {
            BaseTextField(inputString: $inputString, width: 100, height: 50, type: .defaultTextInput, borderColor: .white, backgroundColor: .black, fontColor: .black)
            BaseTextField(inputString: $inputString, width: 200, height: 80, type: .numberInput, borderColor: .white, backgroundColor: .black, fontColor: .black)
            BaseTextField(inputString: $inputString, width: 200, height: 80, type: .imageTextField, image: Image(systemName: "bubble.left"), borderColor: .white, backgroundColor: .black, fontColor: .black)
        }
        .padding()
    }
}
