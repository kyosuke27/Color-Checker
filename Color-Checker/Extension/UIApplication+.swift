import UIKit

extension UIApplication {
    func endEditing(_ force: Bool = true) {
        self.sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil)
    }
}
