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
            myPageUseCase: makeMyPageUseCase(),
            fetchUserIDUseCase: makeFetchUserIDUseCase(),
            clearCredentialsUseCase: makeClearCredentialsUseCase(),
            clearRememberSignInStatusUseCase: makeClearRememberSignInStatusUseCase(),
            clearAutoSignInStatusUseCase: makeClearAutoSignInStatusUseCase(),
            fetchActiveReservationUseCase: makeFetchActiveReservationUseCase(),
            fetchAddressUseCase: makeFetchAddressUseCase()
        )
    }

    func makeMapViewModel() -> MapViewModel {
        MapViewModel(
            mapUseCase: makeMapUseCase(),
            fetchKickScooterUseCase: makeFetchKickScooterUseCase(),
            saveReservationUseCase: makeSaveReservationUseCase(),
            fetchAddressUseCase: makeFetchAddressUseCase(),
            fetchActiveReservationUseCase: makeFetchActiveReservationUseCase()
        )
    }
}
