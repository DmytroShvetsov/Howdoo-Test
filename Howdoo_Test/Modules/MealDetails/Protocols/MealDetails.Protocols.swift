import Foundation

protocol MealDetailsViewProtocol: class {
    func setupRestaurantTitle(_ title: String)
}

protocol MealDetailsPresenterProtocol {
    func viewDidLoad()
    func doneTapped()
}

protocol MealDetailsRouterProtocol {
    func dismissSelf()
}

// MARK: - Namespace
enum MealDetails {
    enum Models {}
}
