import SwiftUI

struct ColorArea: View {
    @Binding var color: Color
    let height: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(color)
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .padding()

    }
}

#Preview {
    ColorAreaContainer()
}

private struct ColorAreaContainer: View {
    @State var color: Color = .white
    var body: some View {
        ColorArea(color: $color, height: 120)
    }
}
