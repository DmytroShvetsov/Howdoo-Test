import Foundation

protocol LaunchViewProtocol: class {
    
}

protocol LaunchPresenterProtocol {
    func viewDidAppear()
}

protocol LaunchRouterProtocol {
    func showMainScreen()
}

// MARK: - Namespace
enum Launch {}
