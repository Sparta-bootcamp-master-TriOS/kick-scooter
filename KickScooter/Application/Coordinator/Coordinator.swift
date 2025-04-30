import UIKit

final class Coordinator {
    var navigationController: UINavigationController
    let diContainer: DIContainer

    init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    func start() {
//        let mainViewController = makeMainViewController()
        let mainViewController = diContainer.makeMapViewController()

        navigationController.viewControllers = [mainViewController]
    }
}
