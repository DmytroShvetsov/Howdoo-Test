import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = view.backgroundColor ?? .white
        loadStaticViews()
        loadStaticNavigationBar()
    }
    
}

// MARK: - LoadViews
@objc extension BaseVC {
    func loadStaticViews() {}
    func loadStaticNavigationBar() {}
}
