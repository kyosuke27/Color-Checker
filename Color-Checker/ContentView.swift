import SwiftUI

struct ContentView: View {
    @State var activeTab: TabData = .home
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                ColorCheckerScreen()
                    .tag(TabData.home)
                // デフォルトのtabBarは非表示にする
                    .toolbar(.hidden, for: .tabBar)
                FavoriteColorScreen()
                    .tag(TabData.favorite)
                    .toolbar(.hidden, for: .tabBar)
            }
            CustomTabBar(
                tint: Color.extendedColors.component.selectedTabColor,
                activeColor: Color.extendedColors.component.defaultTabColor
            )
        }
        .background {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }

    }

    @ViewBuilder
    func CustomTabBar(tint: Color = Color.extendedColors.component.selectedTabColor, activeColor: Color = Color.pink) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(TabData.allCases, id: \.rawValue) {
                TabItem(tint: tint, inactiveColor: activeColor, tab: $0, activeTab: $activeTab)
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.extendedColors.component.buttonBorder)
                .frame(height: 0.2)
                .ignoresSafeArea(edges: .horizontal)
        }
    }
}

struct TabItem: View {
    let tint: Color
    let inactiveColor: Color
    // このコンポーネント内で表示するタブ
    let tab: TabData
    // 現在選択されているタブ
    @Binding var activeTab: TabData

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: tab.systemImage)
                .font(.system(size: 28, weight: .regular))
                .foregroundStyle(activeTab == tab ? tint : inactiveColor)
                .frame(width: 40, height: 40)
                .shadow(color: (activeTab == tab ? tint.opacity(0.6) : .clear), radius: 8, x: 0, y: 0)
                .shadow(color: (activeTab == tab ? tint.opacity(0.4) : .clear), radius: 28, x: 0, y: 0)
                .shadow(color: (activeTab == tab ? tint.opacity(0.2) : .clear), radius: 36, x: 0, y: 0)
            Text(tab.rawValue)
                .foregroundStyle(activeTab ==  tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            // activetabタブの入れ替え
            activeTab = tab
        }
    }
}

#Preview {
    ContentView()
}
