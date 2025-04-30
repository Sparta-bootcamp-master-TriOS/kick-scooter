extension DIContainer {
    func makeTabBarController() -> TabBarController {
        TabBarController(
            addKickScooterViewController: makeAddKickScooterViewController(),
            testMapVC: TestMapVC(),
            myPageViewController: makeMyPageViewController()
        )
    }
}
