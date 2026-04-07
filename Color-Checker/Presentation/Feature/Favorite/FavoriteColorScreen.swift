import SwiftUI

struct FavoriteColorScreen: View {
    @State var colorsData: [ColorData] = []
    @State var tagData: [Tag] = []
    @State var isSelectedIndex: String = ""
    @EnvironmentObject var appSettings: AppSettings
    let repository = FavoriteColorRepositoryImpl()
    let tagReposiroty = TagRepositoryImpl()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tagData) { tag in
                                TagView(isSelectedIndex: $isSelectedIndex, index: tag.id, text: tag.tagName, onTap: {
                                    if isSelectedIndex.isEmpty {
                                        self.isSelectedIndex = tag.id
                                        print("tag.id \(tag.id)")
                                    } else {
                                        self.isSelectedIndex = ""
                                    }
                                }, onDeleteTap: {
                                    tagReposiroty.delete(tag)
                                    tagData = tagReposiroty.readAll()
                                })
                            }
                        }
                    }
                }
                .onChange(of: isSelectedIndex) {newValue in
                    if self.isSelectedIndex.isEmpty {
                        self.colorsData = repository.getColor()
                        print("colorData \(self.colorsData)")
                    } else {
                        self.colorsData = repository.searchByTagId(newValue)
                    }
                }
                .frame(maxWidth: .infinity)
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
                        colorsData = repository.getColor()
                        tagData = tagReposiroty.readAll()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 4)
            }
            .padding()
            .background {
                Image(appSettings.themeColor.stringValue.id)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    let appSetting = AppSettings(id: "1234", themeColor: SettingImageType.blueColor)
    FavoriteColorScreen()
        .environmentObject(appSetting)
}
