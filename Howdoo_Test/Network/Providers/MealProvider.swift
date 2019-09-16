import Foundation

extension Network.MealProvider {
    static func meals(completion: @escaping (Result<[Meal], Network.Common.Error>) -> Void) {
        Network.Core.DataProvider.shared.request(Network.Common.API.meals, callbackQueue: .main, completion: completion)
    }
}
