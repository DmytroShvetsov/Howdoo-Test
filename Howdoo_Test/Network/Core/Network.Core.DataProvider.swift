import Foundation

private typealias DataProvider = Network.Core.DataProvider

// MARK: - DataProvider
extension Network.Core {
    final class DataProvider {
        static let shared: DataProvider = DataProvider()
        
        private let session: URLSession
        
        private init() {
            session = .init(configuration: .ephemeral, delegate: nil, delegateQueue: nil)
            session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        }
    }
}

// MARK: - Requests
extension DataProvider {
    func request<Target: TargetType, T: Decodable>(_ target: Target, callbackQueue: DispatchQueue?, completion: @escaping (Result<T, Network.Common.Error>) -> Void) {
        request(target, callbackQueue: nil) { result in
            let result: Result<T, Network.Common.Error> = Network.Common.Parsers.commonMoyaResponseParser(result: result)
            
            if let callbackQueue = callbackQueue {
                callbackQueue.async { completion(result) }
            } else {
                completion(result)
            }
        }
    }
    
    func request<Target: TargetType>(_ target: Target, callbackQueue: DispatchQueue?, completion: @escaping Network.Common.Completion) {
        do {
            let request = try buildRequest(for: target)
            
            let handler: (Data?, URLResponse?, Error?) -> Void = { [unowned self] in
                let response = self.commonResponseParser(request: request, response: $1, data: $0, error: $2)
                
                if let callbackQueue = callbackQueue {
                    callbackQueue.async { completion(response) }
                } else {
                    completion(response)
                }
            }
            
            let task = session.dataTask(with: request, completionHandler: handler)
            
            task.resume()
        } catch {
            if let callbackQueue = callbackQueue {
                callbackQueue.async { completion(.failure(.requestMapping(error))) }
            } else {
                completion(.failure(.requestMapping(error)))
            }
        }
    }
}


// MARK: - internal logic
private extension DataProvider {
    func buildRequest(for target: TargetType) throws -> URLRequest {
        let url: URL
        
        if target.path.isEmpty {
            url = target.baseURL
        } else {
            url = target.baseURL.appendingPathComponent(target.path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        switch target.task {
            case .requestPlain:
                return request
        }
    }
    
    func commonResponseParser(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) -> Result<Network.Common.Responses.Response, Network.Common.Error> {
        switch (response as? HTTPURLResponse, data, error) {
            case let (.some(response), data, .none):
                let response = Network.Common.Responses.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                return .success(response)
            case let (.some(response), _, .some(error)):
                let response = Network.Common.Responses.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                let error = Network.Common.Error.underlying(error, response)
                return .failure(error)
            case let (_, _, .some(error)):
                let error = Network.Common.Error.underlying(error, nil)
                return .failure(error)
            default:
                let error = Network.Common.Error.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
                return .failure(error)
        }
    }
}
