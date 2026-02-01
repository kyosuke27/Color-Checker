import SwiftUI

struct BaseTextField: View {
    @Binding var inputString:String
    let width:CGFloat
    let height:CGFloat
    var body: some View {
        TextField("255",text: $inputString)
            .frame(width:width,height: height)
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
        BaseTextField(inputString:$inputString,width:100,height: 50)
        BaseTextField(inputString:$inputString,width:200,height:80)
    }
    .padding()
}
