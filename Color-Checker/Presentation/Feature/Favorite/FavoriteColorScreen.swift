import SwiftUI

struct FavoriteColorScreen: View {
    @State var colorsData: [ColorData] = []
    @EnvironmentObject var appSettings: AppSettings
    let repository = FavoriteColorRepositoryImpl()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    ForEach(colorsData) { color in
                        NavigationLink {
                            EditFavoriteColorScreen(selectedColor: color)
                        }label: {
                            FavoriteColorCardView(colorData: color, onDeleteTap: {
                                repository.deleteColor(color.id)
                                colorsData = repository.getColor()
                            }, height: 45)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .onAppear {
                    colorsData =  repository.getColor()
                    print("colorsData \(colorsData)")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 4)
            .background {
                Image(appSettings.themeColor.stringValue)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }

        }
    }
}

#Preview {
    let appSetting = AppSettings(id: "1234", themeColor: SettingImageType.blueColor)
    FavoriteColorScreen()
        .environmentObject(appSetting)
}
