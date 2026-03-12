import SwiftUI

struct MailScreen: View {
    let devMail = "happydevalone@gmail.com"
    let subject = "お問い合わせ"
    var body: some View {
        MailView(address: [devMail], subject: subject, body: "")
    }
}

#Preview {
    MailScreen()
}
