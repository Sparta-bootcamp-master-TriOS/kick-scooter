extension DIContainer {
    func makeMainViewController() -> MainViewController {
        MainViewController(mainViewModel: makeMainViewModel())
    }

    func makeSignUpViewController() -> SignUpViewController {
        SignUpViewController(signUpViewModel: makeSignUpViewModel())
    }

    func makeAddKickScooterViewController() -> AddKickScooterViewController {
        AddKickScooterViewController(addKickScooterViewModel: makeAddKickScooterViewModel())
    }

    func makeMyPageViewController() -> MyPageViewController {
        MyPageViewController(myPageViewModel: makeMyPageViewModel())
    }
}
