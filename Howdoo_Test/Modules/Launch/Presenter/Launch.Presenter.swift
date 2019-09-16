import Foundation

private typealias Presenter = Launch.Presenter

// MARK: - Launch.Presenter
extension Launch {
    final class Presenter {
        weak var view:  LaunchViewProtocol?
        var router:     LaunchRouterProtocol?
        
        private let workflow: Launch.Workflow
        
        init(workflow: Launch.Workflow) {
            self.workflow = workflow
        }
    }
}

// MARK: - LaunchPresenterProtocol
extension Presenter: LaunchPresenterProtocol {
    func viewDidAppear() {
        router?.showMainScreen()
    }
}
