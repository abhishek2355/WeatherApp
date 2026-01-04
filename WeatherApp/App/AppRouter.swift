import UIKit

class AppRouter {
    static func setInitialScreen(in window: UIWindow) {
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
    }
}
