extension DIContainer {
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(authorizeUserUseCase: makeAuthorizeUserUseCase())
    }

    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel(
            signUpUseCase: makeSignUpUseCase(),
            verifyIDAvailabilityUseCase: makeVerifyIDAvailabilityUseCase()
        )
    }

    func makeAddKickScooterViewModel() -> AddKickScooterViewModel {
        AddKickScooterViewModel(
            userNameUseCase: makeUserNameUseCase(),
            saveKickScooterUseCase: makeSaveKickScooterUseCase()
        )
    }

    func makeMyPageViewModel() -> MyPageViewModel {
        MyPageViewModel(
            myPageUseCase: makeMyPageUseCase()
        )
    }
}
