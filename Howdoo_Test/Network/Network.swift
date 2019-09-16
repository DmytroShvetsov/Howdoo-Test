import Foundation

enum Network {
    /// Common
    enum Common {
        typealias JSON = [String: Any]
        typealias JSONCollection = [JSON]
        typealias Completion = (_ result: Result<Responses.Response, Error>) -> Void
        typealias VoidCompletion = (_ result: Result<Void, Error>) -> Void
        typealias JSONCollectionCompletion = (_ result: Result<JSON, Error>) -> Void
        typealias JSONCompletion = (_ result: Result<JSONCollection, Error>) -> Void
        
        /// Requests
        enum Requests  {}
        
        /// Responses
        enum Responses {}
    }
    
    /// Core
    enum Core {
    }
    
    /// MealProvider
    enum MealProvider {}
}
