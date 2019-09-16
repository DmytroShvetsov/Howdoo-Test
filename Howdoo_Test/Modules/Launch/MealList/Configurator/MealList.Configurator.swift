import UIKit

// MARK: - MealList.Configurator
extension MealList {
    final class Configurator {
        private let workflow: MealList.Workflow
        
        init(workflow: MealList.Workflow) {
            self.workflow = workflow
        }
    }
}

extension MealList.Configurator {
    func mealListVC() -> MealList.ViewController {
        let vc         = MealList.ViewController()
        let presenter  = MealList.Presenter(workflow: workflow)
        let router     = MealList.Router()
        
        vc.presenter         = presenter
        presenter.view       = vc
        presenter.router     = router
        router.vc            = vc
        
        return vc
    }
}
