import SwiftUI

struct BaseTextField: View {
    @Binding var inputString:String
    var body: some View {
        TextField("abc",text: $inputString)
            .padding()
            .background(Color.extendedColors.base.BaseBackground)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.extendedColors.component.textFieldBorder,lineWidth: 1)
            )
            .submitLabel(.done)
            .multilineTextAlignment(TextAlignment.center)
            .foregroundStyle(Color.extendedColors.base.baseFontColor)
            .font(.system(size:24))
    }
}

#Preview {
    @Previewable @State var inputString = "abc"
    VStack{
        BaseTextField(inputString:$inputString)
    }
    .padding()
}
