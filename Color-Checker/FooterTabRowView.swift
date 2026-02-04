import SwiftUI

struct FooterTabRowView: View {
    var body: some View {
        HStack{
            VStack{
                Image(systemName:"drop.halffull")
                Text("カラー")
            }
            .frame(maxWidth:.infinity)
            VStack{
                Image(systemName:"drop.halffull")
                Text("カラー")
            }
            .frame(maxWidth:.infinity)

        }
        .frame(maxWidth:.infinity,minHeight:60)
        .background(
            .gray
        )
    }
}

#Preview {
    FooterTabRowView()
}
