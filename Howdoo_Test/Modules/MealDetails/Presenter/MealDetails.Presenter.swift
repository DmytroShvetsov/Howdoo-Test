import Foundation

private typealias Presenter = MealDetails.Presenter

// MARK: - MealDetails.Presenter
extension MealDetails {
    final class Presenter: NSObject {
        weak var view: MealDetailsViewProtocol?
        var router:    MealDetailsRouterProtocol?
        
        private let workflow: MealDetails.Workflow
        
        init(workflow: MealDetails.Workflow) {
            self.workflow = workflow
            super.init()
        }
    }
}

// MARK: - MealDetailsPresenterProtocol
extension Presenter: MealDetailsPresenterProtocol {
    func viewDidLoad() {
        switch workflow {
            case .show(let meal):
                view?.setupRestaurantTitle(meal.restaurantName)
        }
    }

    func doneTapped() {
        router?.dismissSelf()
    }
}
