import UIKit

final class TabBarCoordinator: BaseCoordinator {
    override func start() {
        let tabBar = makeTabBar()
        router.setRootModule(tabBar, hideBar: true)
        
        let modules = [makeSearch(), makeRecent(), makeHome(), makeFavorite(), makeProfile()]
        modules.forEach { coordinator, _ in
            addDependency(coordinator)
            coordinator.start()
        }
        let viewControllers = modules.map { $0.1 }
        tabBar.setViewControllers(viewControllers, animated: false)
    }
}

extension TabBarCoordinator {
    private func makeTabBar() -> BaseViewController & UITabBarController {
        return TabBarController()
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        UITabBarItem(
            title: nil,
            image: UIImage(named: type.icon)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: type.activeIcon)?.withRenderingMode(.alwaysOriginal)
        )
    }
    
    private func makeSearch() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = SearchCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .search)
        return (coordinator, navigationController)
    }
    
    private func makeRecent() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = RecentCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .recent)
        return (coordinator, navigationController)
    }
    
    private func makeHome() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .home)
        return (coordinator, navigationController)
    }
    
    private func makeFavorite() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = FavoriteCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .favorite)
        return (coordinator, navigationController)
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
}