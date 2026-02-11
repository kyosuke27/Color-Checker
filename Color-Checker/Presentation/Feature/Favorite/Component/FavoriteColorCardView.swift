import SwiftUI

struct FavoriteColorCardView: View {
    let colorData:ColorData
    let onTap:()->Void
    var body: some View {
        VStack{
            HStack(alignment: .top){
                ColorCardView(color: Color.rgba(r: Double(colorData.red), g: Double(colorData.green), b: Double(colorData.blue)), side: 40)
                VStack(alignment: .leading){
                    Text("\(colorData.red),\(colorData.green),\(colorData.blue)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text("#\(colorData.hexColor)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    
                }
                .padding(.trailing,8)
                Button {
                    onTap()
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
    let colorData:ColorData = ColorData(red: 100, green: 100, blue: 100, hexColor: "FFFFFF")
    VStack{
        HStack{
            FavoriteColorCardView(colorData:colorData,onTap: {})
            FavoriteColorCardView(colorData: colorData,onTap: {})
        }
    }
}
