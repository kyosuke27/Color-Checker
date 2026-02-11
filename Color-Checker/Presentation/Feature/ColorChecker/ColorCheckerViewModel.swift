import Foundation

struct ColorCheckerViewModel {
    func onEvent(event: ColorCheckerEvent) {
        switch event {
        case .showColor:
            print("hello")
        case .clearAll:
            print("hello")
        }
    }
}
