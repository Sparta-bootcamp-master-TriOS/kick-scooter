extension DIContainer {
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(
            authorizeUserUseCase: makeAuthorizeUserUseCase(),
            saveCredentialsUseCase: makeSaveCredentialsUseCase(),
            fetchCredentialsUseCase: makeFetchCredentialsUseCase(),
            saveRememberSignInStatusUseCase: makeSaveRememberSignInStatusUseCase(),
            fetchRememberSignInStatusUseCase: makeFetchRememberSignInStatusUseCase(),
            saveAutoSignInStatusUseCase: makeSaveAutoSignInStatusUseCase(),
            fetchAutoSignInStatusUseCase: makeFetchAutoSignInStatusUseCase()
        )
    }

    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel(
            signUpUseCase: makeSignUpUseCase(),
            verifyIDAvailabilityUseCase: makeVerifyIDAvailabilityUseCase()
        )
    }

    func makeAddKickScooterViewModel() -> AddKickScooterViewModel {
        AddKickScooterViewModel(
            fetchUserNameUseCase: makeUserNameUseCase(),
            saveKickScooterUseCase: makeSaveKickScooterUseCase()
        )
    }

    func makeMyPageViewModel() -> MyPageViewModel {
        MyPageViewModel(
            myPageUseCase: makeMyPageUseCase()
        )
    }

    func makeMapViewModel() -> MapViewModel {
        MapViewModel(
            mapUseCase: makeMapUseCase(),
            fetchKickScooterUseCase: makeFetchKickScooterUseCase()
        )
    }
}
