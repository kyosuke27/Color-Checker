import SwiftUI

struct FavoriteColorCardView: View {
    let colorData: ColorData
    let onDeleteTap: () -> Void
    let height: CGFloat
    let background: Color
    let shadowColor: Color
    let fontColor: Color

    func numToPercent(fNum: Float) -> Int {
        return Int((fNum * 100).rounded())
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
                        .foregroundStyle(fontColor)
                    Text("#\(colorData.hexColor)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(fontColor)
                    Spacer()

                }
                .frame(height: height)
                .padding(.trailing, 4)
                Spacer()
                Button {
                    onDeleteTap()
                } label: {
                    Image(systemName: "xmark")
                        .tint(fontColor)
                        .frame(width: 12, height: 12)
                }
            }
            Divider()
                .background(Color.extendedColors.component.borderColor)
            Text("透明度 \(numToPercent(fNum: colorData.alpha))%")
                .font(.system(size: 14))
                .minimumScaleFactor(0.6)
                .foregroundStyle(fontColor)
            Text("メモ：\(colorData.memo)")
                .font(.system(size: 14))
                .minimumScaleFactor(0.6)
                .foregroundStyle(fontColor)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(background)
                .shadow(color: shadowColor, radius: 2, x: 2, y: 2)
        )
    }
}

#Preview {
    let colorData: ColorData = ColorData(id: UUID().uuidString, red: 100, green: 100, blue: 100, alpha: 0.5, hexColor: "FFFFFF", memo: "Test", tagId: "")
    VStack {
        HStack {
            FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50, background: .black.opacity(0.8), shadowColor: .black.opacity(0.2), fontColor: .black)
            FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50, background: .black.opacity(0.8), shadowColor: .black.opacity(0.2), fontColor: .black)
        }
        FavoriteColorCardView(colorData: colorData, onDeleteTap: {}, height: 50, background: .black.opacity(0.8), shadowColor: .black.opacity(0.2), fontColor: .black)
    }
}
