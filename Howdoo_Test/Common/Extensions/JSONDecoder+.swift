import Foundation

// MARK: - defined decoders
extension JSONDecoder {
    static func defaultDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
