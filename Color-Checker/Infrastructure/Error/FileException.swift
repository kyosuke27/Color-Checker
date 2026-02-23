import Foundation

enum FileException: Error {
    case fileNotFound(URL)
}
