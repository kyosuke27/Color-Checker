import SwiftUI

struct ColorCheckerScreen: View {
    @State var red: String = ""
    @State var green:String = ""
    @State var blue:String = ""
    @State var color:Color = .white
    let maxValue = 255
    let minLimtValue = 0
    
    private func rounded2(value:Double)->Double{
        return (value*100).rounded()/100
    }
    
    private func RGBtoColor() -> Color{
        let calcR = Double(min(max((Int(red) ?? 0), minLimtValue),maxValue))/255.0
        let calcG = Double(min(max((Int(green) ?? 0), minLimtValue),maxValue))/255.0
        let calcB = Double(min(max((Int(blue) ?? 0), minLimtValue),maxValue))/255.0
        return Color(red: rounded2(value:calcR), green: rounded2(value: calcG), blue: rounded2(value: calcB))
    }
    
    var body: some View {
        VStack(spacing:16){
            Text("Color Checker")
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
                .font(.system(size: 38))
                .padding()
            RGBRow(red:$red , green:$green , blue:$blue )
            ColorArea(color: $color, height: 240)
            HStack{
                BaseButton(text: "カラー表示", width: 120, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                    color = RGBtoColor()
                })
                BaseButton(text: "リセット", width: 120, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                    red = ""
                    green = ""
                    blue = ""
                    color = .white
                })
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.extendedColors.base.BaseBackground)
    }
}

#Preview {
    ColorCheckerScreen()
}
