import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

struct AppScreen: View {
    @State var activeTab: TabData = .home
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var interstitialViewModel: InterstitialViewModel
    @StateObject var colorCheckerViewModel: ColorCheckerViewModel
    init(colorCheckerViewModel: ColorCheckerViewModel) {
        self._colorCheckerViewModel = StateObject(wrappedValue: colorCheckerViewModel)
    }
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                ColorCheckerScreen(onEvent: { colorCheckerViewModel.onEvent(event: $0) }, state: colorCheckerViewModel.state)
                    .tag(TabData.home)
                // デフォルトのtabBarは非表示にする
                    .toolbar(.hidden, for: .tabBar)
                FavoriteColorScreen()
                    .tag(TabData.favorite)
                    .toolbar(.hidden, for: .tabBar)
                SettingScreen()
                    .tag(TabData.setting)
                    .toolbar(.hidden, for: .tabBar)
            }
            VStack {
                // AdSizeBanner:320*50サイズ
                AdmobBannerView(AdSizeBanner)
                    .frame(height: 50)
            }
            CustomTabBar(
                tint: Color.extendedColors.component.selectedTabColor,
                activeColor: Color.extendedColors.component.defaultTabColor
            )
        }
        .background {
            Image(appSettings.themeColor.stringValue)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        
    }
    
    @ViewBuilder
    func CustomTabBar(tint: Color = Color.extendedColors.component.selectedTabColor, activeColor: Color = Color.pink) -> some View {
        HStack(alignment: .bottom, spacing: 16) {
            ForEach(TabData.allCases, id: \.rawValue) {
                TabItem(tint: tint, inactiveColor: activeColor, tab: $0, activeTab: $activeTab)
            }
        }
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
                .foregroundStyle(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            // activetabタブの入れ替え
            activeTab = tab
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .notDetermined:
                    print("トラッキング許可の有無が未設定です")

                case .restricted:
                    print("トラッキングが制限されています")

                case .denied:
                    print("トラッキングが拒否されました")

                case .authorized:
                    print("トラッキングが許可されました")

                @unknown default:
                    print("不明な状態です")
                }
            }
        }
    }
}

#Preview {
    let interStitialViewModel: InterstitialViewModel = InterstitialViewModel()
    let colorCheckerViewModel: ColorCheckerViewModel = ColorCheckerViewModel(interStitialViewModel: interStitialViewModel)
    AppScreen(colorCheckerViewModel: colorCheckerViewModel)
}
