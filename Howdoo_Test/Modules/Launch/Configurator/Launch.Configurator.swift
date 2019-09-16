import UIKit

private typealias Configurator = Launch.Configurator

// MARK: - Launch.Configurator
extension Launch {
    final class Configurator {
        private let workflow: Launch.Workflow
        
        init(workflow: Launch.Workflow) {
            self.workflow = workflow
        }
    }
}

extension Configurator {
    func launchVC() -> Launch.ViewController {
        let vc         = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(withIdentifier: "LaunchVC") as! Launch.ViewController
        let presenter  = Launch.Presenter(workflow: workflow)
        let router     = Launch.Router()
        
        vc.presenter         = presenter
        presenter.view       = vc
        presenter.router     = router
        router.vc            = vc
        
        return vc
    }
}
