import UIKit

private typealias Router = MealList.Router

// MARK: - MealList.Router
extension MealList {
    final class Router {
        weak var vc: UIViewController?
    }
}

// MARK: - MealListRouterProtocol
extension Router: MealListRouterProtocol {
    func showMealDetails(_ meal: Meal) {
        let mealDetails = MealDetails.Configurator.init(workflow: .show(meal: meal)).mealDetailsVC()
        vc?.present(BaseNavigationController(rootViewController: mealDetails), animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "Please Try Again Later\n\(error.localizedDescription)", preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .cancel))
        vc?.present(alertController, animated: true, completion: nil)
    }
}
