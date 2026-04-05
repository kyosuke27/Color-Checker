import SwiftUI

struct SliderView: View {
    @Binding var redSlider: Double
    @Binding var greenSlider: Double
    @Binding var blueSlider: Double
    var body: some View {
        Slider(value: $redSlider, in: 0...255, step: 1)
            .tint(.red)
        Slider(value: $greenSlider, in: 0...255, step: 1)
            .tint(.green)
        Slider(value: $blueSlider, in: 0...255, step: 1)
            .tint(.blue)
    }
}

#Preview {
    SliderCopntainer()
}

private struct SliderCopntainer: View {
    @State var redSlider: Double = 128
    @State var greenSlider: Double = 128
    @State var blueSlider: Double = 128

    var body: some View {
        SliderView(redSlider: $redSlider, greenSlider: $greenSlider, blueSlider: $blueSlider)
    }
}
