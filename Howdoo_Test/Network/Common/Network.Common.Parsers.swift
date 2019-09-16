import Foundation

// MARK: - Parsers
extension Network.Common {
    enum Parsers {
        static func commonMoyaResponseParser(result: Result<Responses.Response, Error>) -> Result<JSON, Error> {
            switch result {
                case let .success(response):
                    do {
                        let mapedJSON = try response.mapJSON()
                        guard let json = mapedJSON as? JSON else { return .failure(.jsonMapping(response)) }
                        return .success(json)
                    } catch {
                        return .failure(.jsonMapping(response))
                    }
                case let .failure(error):
                    return .failure(error)
            }
        }
        
        static func commonMoyaResponseParser(result: Result<Responses.Response, Error>) -> Result<JSONCollection, Error> {
            switch result {
                case let .success(response):
                    do {
                        let mapedJSON = try response.mapJSON()
                        guard let json = mapedJSON as? JSONCollection else { return .failure(.jsonMapping(response)) }
                        return .success(json)
                    } catch {
                        return .failure(.jsonMapping(response))
                    }
                case let .failure(error):
                    return .failure(error)
            }
        }
        
        static func commonMoyaResponseParser(result: Result<Responses.Response, Error>) -> Result<Void, Error> {
            switch result {
                case .success:
                    return .success(())
                
                case let .failure(error):
                    if let response = error.response {
                        return .failure(parseResponseForCustomError(response: response, error: error))
                    }
                    return .failure(error)
            }
        }
        
        static func commonMoyaResponseParser<T: Decodable>(result: Result<Responses.Response, Error>) -> Result<T, Error> {
            switch result {
                case let .success(response):
                    do {
                        let model = try JSONDecoder.defaultDecoder().decode(T.self, from: response.data)
                        return .success(model)
                    } catch {
                        return .failure(parseResponseForCustomError(response: response, error: nil))
                    }
                
                case let .failure(error):
                    if let response = error.response {
                        return .failure(parseResponseForCustomError(response: response, error: error))
                    }
                    return .failure(error)
            }
        }
    }
}

// MARK: - private convenience logic
private extension Network.Common.Parsers {
    static func parseResponseForCustomError(response: Network.Common.Responses.Response, error: Network.Common.Error?) -> Network.Common.Error {
        switch response.statusCode {
            case 200:
                return .modelMapping(response)
            
            case 401, 404:
                return .statusCode(response.statusCode, error)
            
            default:
                if let error = error { return error }
                return .statusCode(response.statusCode, nil)
        }
    }
}
