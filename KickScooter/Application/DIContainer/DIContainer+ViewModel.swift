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
}
