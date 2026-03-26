import SwiftUI

struct TagView: View {
    @Binding var isSelectedIndex: String
    let index: String
    let text: String
    let onTap: () -> Void
    
    let onDeleteTap: () -> Void

    private var isSelected: Bool {
        self.index == self.isSelectedIndex
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(text)
                .foregroundStyle(Color.extendedColors.base.baseFontColor)
            Button {
                // アクション
                onDeleteTap()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundStyle(Color.extendedColors.base.baseFontColor)
                    .frame(width: 6, height: 6)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(999)
            }
            .padding(.trailing, 4)
        }
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            onTap()
        }
        .padding(.leading, 8)
        .padding(.trailing, 2)
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
    TagViewPreviewContainer()
}

private struct TagViewPreviewContainer: View {
    
    @State var selectedIndex = "1"
    var body: some View {
        let indexs = ["1", "2", "3"]
        ForEach(indexs.indices, id: \.self) {index in
            TagView(isSelectedIndex: $selectedIndex, index: indexs[index], text: "#Sample", onTap: { selectedIndex = indexs[index] }, onDeleteTap: {})
        }
    }
}
