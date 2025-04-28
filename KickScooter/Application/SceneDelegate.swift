import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()

        let diContainer = DIContainer()

        let coordinator = Coordinator(
            navigationController: navigationController,
            diContainer: diContainer
        )

        coordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
        self.coordinator = coordinator
    }
}
