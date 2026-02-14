import SwiftUI

struct FavoriteColorScreen: View {
    @State var colorsData: [ColorData] = []
    let repository = FavoriteColorRepositoryImpl()
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20){
            ForEach(colorsData,id:\.self){ color in
                FavoriteColorCardView(colorData: color, onTap: {},height:50)
            }
            Button {
                let colors = repository.getColor()
                colorsData = colors
                print("Favorite get Data Action \(colors)")
            } label: {
                Text("Get Data")
            }
        }
        
        .onAppear{
            colorsData =  repository.getColor()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
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
