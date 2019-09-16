import UIKit

// MARK: - MealDetails.Configurator
extension MealDetails {
    final class Configurator {
        private let workflow: MealDetails.Workflow
        
        init(workflow: MealDetails.Workflow) {
            self.workflow = workflow
        }
    }
}

extension MealDetails.Configurator {
    func mealDetailsVC() -> MealDetails.ViewController {
        let vc         = MealDetails.ViewController()
        let presenter  = MealDetails.Presenter(workflow: workflow)
        let router     = MealDetails.Router()
        
        vc.presenter         = presenter
        presenter.view       = vc
        presenter.router     = router
        router.vc            = vc
        
        return vc
    }
}
