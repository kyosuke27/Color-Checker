import SwiftUI

struct ColorCardView: View {
    let color:Color
    let side:CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .stroke(Color.extendedColors.component.borderColor,lineWidth:1)
            .frame(width: side,height: side)
    }
}

#Preview {
    ColorCardView(color: .blue, side: 85)
}
