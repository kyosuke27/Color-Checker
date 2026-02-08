import SwiftUI

struct FavoriteColorCardView: View {
    let rgbString:String
    let hexString:String
    let color:Color
    var body: some View {
        VStack{
            HStack(alignment: .top){
                ColorCardView(color: color, side: 40)
                VStack(alignment: .leading){
                    Text(hexString)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text(rgbString)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    
                }
                .padding(.trailing,8)
                Button {
                    print("close")
                } label: {
                    Image(systemName: "xmark")
                        .tint(Color.extendedColors.base.baseFontColor)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.extendedColors.component.compBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.extendedColors.component.borderColor,lineWidth: 1)
        )
    }
}

#Preview {
    VStack{
        HStack{
            FavoriteColorCardView(rgbString: "49,38,250", hexString: "#11FC4", color: .blue)
            FavoriteColorCardView(rgbString: "49,38,250", hexString: "#11FC4", color: .purple)
        }
    }
}
