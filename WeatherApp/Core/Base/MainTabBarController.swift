import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeVC = WeatherViewController()
        let cityVC = CityWeatherViewController()
        
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        let cityNavigationController = UINavigationController(rootViewController: cityVC)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        cityNavigationController.tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "building.2"), tag: 1)
        
        viewControllers = [homeNavigationController, cityNavigationController]
    }
}
