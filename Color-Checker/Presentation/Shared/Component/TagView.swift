import SwiftUI

struct TagView: View {
    @Binding var isSelectedIndex: String
    let themeColor: Theme
    let tag: Tag
    let onTap: () -> Void
    
    let onDeleteTap: () -> Void

    private var isSelected: Bool {
        self.tag.id == self.isSelectedIndex
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(tag.tagName)
                .foregroundStyle(themeColor.fontColor)
            Button {
                // アクション
                onDeleteTap()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundStyle(themeColor.fontColor)
                    .frame(width: 6, height: 6)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .background(themeColor.tagColor.tagDeleteButtonBackgroundColor)
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
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? themeColor.tagColor.tagBackground.opacity(0.4) : themeColor.tagColor.tagBackground)
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
        )
    }
}

#Preview {
    TagViewPreviewContainer()
}

private struct TagViewPreviewContainer: View {
    
    @State var selectedIndex = "1"
    var body: some View {
        let tags: [Tag] = [
            Tag(id: "1", tagName: "1"),
            Tag(id: "2", tagName: "2"),
            Tag(id: "3", tagName: "3")
        ]
        ForEach(tags) { tag in
            TagView(
                isSelectedIndex: $selectedIndex,
                themeColor: defaultTheme(),
                tag: tag,
                onTap: {},
                onDeleteTap: {}
            )
        }
    }
}
