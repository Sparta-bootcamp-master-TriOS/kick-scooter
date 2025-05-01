extension DIContainer {
    func makeTabBarController() -> TabBarController {
        TabBarController(
            addKickScooterViewController: makeAddKickScooterViewController(),
            mapViewController: makeMapViewController(),
            myPageViewController: makeMyPageViewController()
        )
    }
}
