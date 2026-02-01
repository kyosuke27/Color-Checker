import SwiftUI

struct RGBInput: View {
    @Binding var text:String
    let labelString:String
    let fontColor:Color
    
    var body: some View {
        HStack{
            Text(labelString)
                .font(.system(size: 34))
                .padding(.horizontal,12)
                .foregroundStyle(fontColor)
            BaseTextField(inputString: $text,width: 80,height: 34)
        }
    }
}

#Preview {
    @Previewable @State var inputString1 = "255"
    @Previewable @State var inputString2 = "255"
    @Previewable @State var inputString3 = "255"
    RGBInput(text: $inputString1,labelString:"R",fontColor: Color.extendedColors.base.redFontColor)
    RGBInput(text: $inputString2,labelString:"G",fontColor: Color.extendedColors.base.greenFontColor)
    RGBInput(text: $inputString3,labelString:"B",fontColor: Color.extendedColors.base.blueFontColor)
}
