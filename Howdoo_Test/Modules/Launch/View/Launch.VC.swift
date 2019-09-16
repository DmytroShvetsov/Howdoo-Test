import UIKit

// for storyboard purpose, it is the only way to reuse it.
final class LaunchVC: Launch.ViewController {}

private typealias ViewController = Launch.ViewController

// MARK: - Launch.ViewController
extension Launch {
    class ViewController: BaseVC {
        final var presenter: LaunchPresenterProtocol?
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            presenter?.viewDidAppear()
        }
    }
}

// MARK: - LaunchViewProtocol
extension ViewController: LaunchViewProtocol {
    override func loadStaticNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}
