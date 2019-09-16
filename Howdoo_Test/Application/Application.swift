import UIKit

final class Application {
    static let shared: Application = Application()
    
    private var rootVCClosure: (() -> UIViewController)!
    
    private init() {}
}

// MARK: - ApplicationProtocol
extension Application {
    func didFinishLaunchingWithOptions(_ launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        Application.startProgram()
    }
    
    func rootViewController() -> UIViewController? {
        precondition(rootVCClosure != nil, "Application root ViewController must be setted.")
        return rootVCClosure()
    }
}

// MARK: - class methods
extension Application {
    static func setRootViewController(_ closure: @escaping @autoclosure () -> UIViewController) {
        Application.shared.rootVCClosure = closure
    }
}


// MARK: - startProgram
private extension Application {
    static func startProgram(with vc: UIViewController? = nil) {
        let window = loadWindow()
        window.rootViewController = BaseNavigationController(rootViewController: Launch.Configurator(workflow: .default).launchVC())
    }
    
    static func loadWindow() -> UIWindow {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        window.makeKeyAndVisible()
        return window
    }
}
