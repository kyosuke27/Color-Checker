import SwiftUI

struct TagView: View {
    @Binding var isSelectedIndex: String
    let index: String
    let text: String
    let onTap: () -> Void

    private var isSelected: Bool {
        self.index == self.isSelectedIndex
    }

    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
        }
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            onTap()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(isSelected ? Color.extendedColors.component.compSelectBackground : Color.extendedColors.component.compBackground)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    Color.extendedColors.component.textFieldBorder.opacity(0.6))
        }
    }
}

#Preview {
    @Previewable @State var selectedIndex = "1"
    let indexs = ["1", "2", "3"]
    ForEach(indexs.indices, id: \.self) {index in
        TagView(isSelectedIndex: $selectedIndex, index: indexs[index], text: "#Sample", onTap: { selectedIndex = indexs[index] })
    }
}
