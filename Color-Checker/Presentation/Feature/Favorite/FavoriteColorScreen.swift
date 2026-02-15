import SwiftUI

struct FavoriteColorScreen: View {
    @State var colorsData: [ColorData] = []
    let repository = FavoriteColorRepositoryImpl()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
            ForEach(colorsData) { color in
                FavoriteColorCardView(colorData: color, onTap: {}, height: 45)
            }
        }
        .onAppear {
            colorsData =  repository.getColor()
            print("colorsData \(colorsData)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 4)
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }

    }
}

#Preview {
    FavoriteColorScreen()
}
