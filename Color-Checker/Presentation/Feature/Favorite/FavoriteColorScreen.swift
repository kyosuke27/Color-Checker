import SwiftUI

struct FavoriteColorScreen: View {
    @State var colorsData: [ColorData] = []
    let repository = FavoriteColorRepositoryImpl()
    init() {
        colorsData = repository.getColor()
    }

    var body: some View {
        VStack {
//            ForEach(colorsData,id:\){ color in
//            }
        }
    }
}

#Preview {
    FavoriteColorScreen()
}
