import UIKit

private typealias Router = MealDetails.Router

// MARK: - MealDetails.Router
extension MealDetails {
    final class Router {
        weak var vc: UIViewController?
    }
}

// MARK: - MealDetailsRouterProtocol
extension Router: MealDetailsRouterProtocol {
    func dismissSelf() {
        vc?.dismiss(animated: true, completion: nil)
    }
}
