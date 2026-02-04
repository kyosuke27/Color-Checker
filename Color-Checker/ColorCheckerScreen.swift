import SwiftUI

struct ColorCheckerScreen: View {
    @State var red: String = ""
    @State var green:String = ""
    @State var blue:String = ""
    @State var color:Color = .white
    @State var opacity:Double = 1.0
    let maxValue = 255
    let minLimtValue = 0
    
    private func rounded2(value:Double)->Double{
        print((value*100).rounded()/100)
        return (value*100).rounded()/100
    }
    
    private func RGBtoColor() -> Color{
        let calcR = Double(min(max((Int(red) ?? 0), minLimtValue),maxValue))/255.0
        let calcG = Double(min(max((Int(green) ?? 0), minLimtValue),maxValue))/255.0
        let calcB = Double(min(max((Int(blue) ?? 0), minLimtValue),maxValue))/255.0
        return Color(red: rounded2(value:calcR), green: rounded2(value: calcG), blue: rounded2(value: calcB),opacity: opacity)
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
                Text("A : \(rounded2(value:opacity))")
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
             Slider(value:$opacity,in: 0...1)
                .onChange(of: opacity) { _ , newValue in
                    opacity = newValue
                    color = RGBtoColor()
                }   
            }
            HStack{
                BaseButton(text: "カラー表示", width: 180, bodyColor: Color.extendedColors.component.buttonBlueBackground, onTap: {
                    color = RGBtoColor()
                })
                BaseButton(text: "リセット", width: 180, bodyColor: Color.extendedColors.component.buttonBackground, onTap: {
                    red = ""
                    green = ""
                    blue = ""
                    color = .white
                })
            }
            HStack{
                BaseButton(text: "保存", width: 360, bodyColor: Color.extendedColors.component.buttonPurpleBackground, onTap: {})
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal,16)
        .background(
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ColorCheckerScreen()
}
