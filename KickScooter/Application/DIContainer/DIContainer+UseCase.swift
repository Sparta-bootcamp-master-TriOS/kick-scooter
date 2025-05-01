extension DIContainer {
    func makeAuthorizeUserUseCase() -> AuthorizeUserUseCase {
        DefaultAuthorizeUserUseCase(
            authorizeUserRepository: makeAuthorizeUserRepository(),
            userSessionRepository: userSessionRepository ?? makeUserSessionRepository()
        )
    }

    func makeSignUpUseCase() -> SignUpUseCase {
        DefaultSignUpUseCase(signUpRepository: makeSignUpRepository())
    }

    func makeVerifyIDAvailabilityUseCase() -> VerifyIDAvailabilityUseCase {
        DefaultVerifyIDAvailabilityUseCase(verifyIDAvailabilityRepository: makeVerifyIDAvailabilityRepository())
    }

    func makeUserNameUseCase() -> FetchUserNameUseCase {
        DefaultFetchUserNameUseCase(userSessionRepository: userSessionRepository ?? makeUserSessionRepository())
    }

    func makeMyPageUseCase() -> MyPageUseCase {
        DefaultMyPageUseCase(myPageRepository: makeMyPageRepository())
    }

    func makeMapUseCase() -> MapUseCase {
        DefaultMapUseCase(mapRepository: makeMapRepository())
    }

    func makeSaveKickScooterUseCase() -> SaveKickScooterUseCase {
        DefaultSaveKickScooterUseCase(kickScooterRepository: makeKickScooterRepository())
    }

    func makeSaveCredentialsUseCase() -> SaveCredentialsUseCase {
        DefaultSaveCredentialsUseCase(credentialsRepository: makeCredentialsRepository())
    }

    func makeFetchCredentialsUseCase() -> FetchCredentialsUseCase {
        DefaultFetchCredentialsUseCase(credentialsRepository: makeCredentialsRepository())
    }

    func makeClearCredentialsUseCase() -> ClearCredentialsUseCase {
        DefaultClearCredentialsUseCase(credentialsRepository: makeCredentialsRepository())
    }

    func makeSaveRememberSignInStatusUseCase() -> SaveRememberSignInStatusUseCase {
        DefaultSaveRememberSignInStatusUseCase(rememberSignInStatusRepository: makeRememberSignInStatusRepository())
    }

    func makeFetchRememberSignInStatusUseCase() -> FetchRememberSignInStatusUseCase {
        DefaultFetchRememberSignInStatusUseCase(rememberSignInStatusRepository: makeRememberSignInStatusRepository())
    }

    func makeClearRememberSignInStatusUseCase() -> ClearRememberSignInStatusUseCase {
        DefaultClearRememberSignInStatusUseCase(rememberSignInStatusRepository: makeRememberSignInStatusRepository())
    }

    func makeSaveAutoSignInStatusUseCase() -> SaveAutoSignInStatusUseCase {
        DefaultSaveAutoSignInStatusUseCase(autoSignInStatusRepository: makeAutoSignInStatusRepository())
    }

    func makeFetchAutoSignInStatusUseCase() -> FetchAutoSignInStatusUseCase {
        DefaultFetchAutoSignInStatusUseCase(autoSignInStatusRepository: makeAutoSignInStatusRepository())
    }

    func makeClearAutoSignInStatusUseCase() -> ClearAutoSignInStatusUseCase {
        DefaultClearAutoSignInStatusUseCase(autoSignInStatusRepository: makeAutoSignInStatusRepository())
    }

    func makeFetchUserIDUseCase() -> FetchUserIDUseCase {
        DefaultFetchUserIDUseCase(userSessionRepository: userSessionRepository ?? makeUserSessionRepository())
    }
}
