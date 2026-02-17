import SwiftUI

enum ToastType{
    case success
}

struct ToastView: View {
    let toastType:ToastType
    var body: some View {
        switch toastType{
        case .success:
            registSucess()
        }
    }
    
    private func registSucess()->some View{
        return ZStack {
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
    ToastView(toastType: ToastType.success)
}
