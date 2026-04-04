import Foundation

extension String {
    func stringToInt() -> Int {
        return Int(self) ?? 0
    }
}
