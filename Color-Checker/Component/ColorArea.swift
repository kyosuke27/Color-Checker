import SwiftUI

struct ColorArea: View {
    @Binding var color:Color
    let height:CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(color)
            .frame(maxWidth: .infinity,minHeight:height,maxHeight: height)
            .padding()
        
    }
}

#Preview {
    @Previewable @State var color:Color = .white
    ColorArea(color: $color,height: 120)
}
