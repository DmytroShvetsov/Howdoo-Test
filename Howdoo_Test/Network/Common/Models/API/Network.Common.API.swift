import Foundation

// MARK: - API
extension Network.Common {
    enum API {
        case
            meals
    }
}

// MARK: - TargetType
extension Network.Common.API: TargetType {
    var baseURL: URL {
        var url: URL
        
        switch self {
            case .meals:
                let _url = URL(string: "https://gist.githubusercontent.com/gonchs/b657e6043e17482cae77a633d78f8e83/raw/7654c0db94a3f430888fac0caac675c7e811030a/")
                assert(_url != nil, "url must not be nil")
                url = _url ?? URL(string: "https://google.com")!
        }
        
        return url
    }
    
    var path: String {
        switch self {
            case .meals:
                return "test_data.json"
        }
    }
    
    var method: Network.Common.Method {
        switch self {
            case .meals:
                return .get
        }
    }
    
    var task: Network.Common.Task {
        switch self {
            case .meals:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
            default:
                return nil
        }
    }
}
