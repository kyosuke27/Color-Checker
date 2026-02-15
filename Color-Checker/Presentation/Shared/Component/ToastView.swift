import SwiftUI

struct ToastView: View {
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                Spacer()
                Text("登録しました")
                    .font(.system(size: 24))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.extendedColors.component.toastBackgroundColor)
        }
        .cornerRadius(8)
    }
}

#Preview {
    ToastView()
}
