import Foundation

extension Network.Common {
    enum Error: Swift.Error {
        case requestMapping(Swift.Error)
        case parameterEncoding
        case underlying(Swift.Error, Network.Common.Responses.Response?)
        case jsonMapping(Network.Common.Responses.Response)
        case modelMapping(Network.Common.Responses.Response?)
        case custom(error: Swift.Error)
        case statusCode(Int, Swift.Error?)
    }
}

// MARK: - Depending on error type, returns a `Response` object.
extension Network.Common.Error {
    var response: Network.Common.Responses.Response? {
        switch self {
            case .underlying(_, let response),
                 .modelMapping(let response):
                return response
            case .jsonMapping(let response):
                return response
            default:
                return nil
        }
    }
}

// MARK: - LocalizedError
extension Network.Common.Error: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .requestMapping:
                return "Request mapping error"
            case .parameterEncoding:
                return "Failed to encode parameters for URLRequest."
            case .underlying(let error, _),
                 .custom(let error):
                return error.localizedDescription
            case .jsonMapping:
                return "Failed to map data to JSON."
            case .modelMapping:
                return "Failed to map data to Model."
            case .statusCode(let statusCode, let error):
                if statusCode == 401 {
                    return "Unauthorized"
                } else if statusCode == 404 {
                    return "The specified resource was not found"
                } else if let error = error {
                    return error.localizedDescription
                } else {
                    return "Status Code: \(statusCode)"
                }
        }
    }
}
