import SwiftUI

struct FavoriteColorCardView: View {
    let colorData: ColorData
    let onDeleteTap: () -> Void
    let height: CGFloat

    func numToPercent(fNum: Float) -> Int {
        return Int((fNum*100).rounded())
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .center) {
                        ColorCardView(color: Color.rgba(r: Double(colorData.red), g: Double(colorData.green), b: Double(colorData.blue)), side: height)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Spacer()
                    Text("\(colorData.red),\(colorData.green),\(colorData.blue)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text("#\(colorData.hexColor)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Spacer()

                }
                .frame(height: height)
                .padding(.trailing, 4)
                Spacer()
                Button {
                    onDeleteTap()
                } label: {
                    Image(systemName: "xmark")
                        .tint(Color.extendedColors.base.baseFontColor)
                        .frame(width: 12, height: 12)
                }
            }
            Divider()
                .background(Color.extendedColors.component.borderColor)
            Text("透明度 \(numToPercent(fNum: colorData.alpha))%")
                .font(.system(size: 14))
                .minimumScaleFactor(0.6)
            Text("メモ：\(colorData.memo)")
                .font(.system(size: 14))
                .minimumScaleFactor(0.6)

        }

        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.extendedColors.component.compBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.extendedColors.component.borderColor, lineWidth: 1)
        )
    }
}

#Preview {
    let colorData: ColorData = ColorData(id: UUID().uuidString, red: 100, green: 100, blue: 100, alpha: 0.5, hexColor: "FFFFFF", memo: "Test")
    VStack {
        HStack {
            FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50)
            FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50)
        }
        FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50)
    }
}
