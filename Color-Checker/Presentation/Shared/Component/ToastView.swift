import SwiftUI

enum ToastType {
    case success
    case copySuccess
    case error(String)
    case none
}

struct ToastView: View {
    let toastType: ToastType

    var body: some View {
        if let config = config(for: toastType) {
            toastView(color: config.color, text: config.text, image: config.image)
        } else {
            EmptyView()
        }
    }

    // 設定値のまとまりを返すだけのメソッド
    private func config(for type: ToastType) -> (color: Color, text: String, image: String)? {
        switch type {
        case .success:
            return (Color.extendedColors.component.toastBackgroundColor, "登録しました", "checkmark.circle.fill")
        case .copySuccess:
            return (Color.extendedColors.component.blueToastBackgroundColor, "コピーしました", "info.circle")
        case .error(let errorText):
            return (Color.extendedColors.component.errorToastBackgroundColor, errorText, "exclamationmark.circle")
        case .none:
            return nil
        }
    }

    private func toastView(color: Color, text: String, image: String) -> some View {
        ZStack {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 28, height: 28)
                Spacer()
                Text(text)
                    .font(.system(size: 24))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
        }
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 12) {
        ToastView(toastType: .success)
        ToastView(toastType: .copySuccess)
        ToastView(toastType: .error("入力間違いです"))
        ToastView(toastType: .none)
    }
    .padding()
}
