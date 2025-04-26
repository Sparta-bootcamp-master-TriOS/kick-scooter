extension DIContainer {
    func makeMainViewController() -> MainViewController {
        MainViewController(mainViewModel: makeMainViewModel())
    }

    func makeSignUpViewController() -> SignUpViewController {
        SignUpViewController()
    }
}
