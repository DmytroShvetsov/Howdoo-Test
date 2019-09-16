import UIKit

private typealias Router = Launch.Router

// MARK: - Launch.Router
extension Launch {
    final class Router: NSObject {
        weak var vc: UIViewController?
    }
}

// MARK: - LaunchRouterProtocol
extension Router: LaunchRouterProtocol {
    func showMainScreen() {
        let anim = CATransition.get(duration: 0.3, type: .fade)
        UIApplication.shared.keyWindow?.layer.add(anim, forKey: "rootVCanim")
        UIApplication.shared.keyWindow?.rootViewController = Application.shared.rootViewController()
    }
}
