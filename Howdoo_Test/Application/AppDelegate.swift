import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Application.setRootViewController(BaseNavigationController(rootViewController: MealList.Configurator(workflow: .default).mealListVC()))
        Application.shared.didFinishLaunchingWithOptions(launchOptions)
        return true
    }

}
