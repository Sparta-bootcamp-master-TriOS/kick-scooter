extension DIContainer {
    func makeAuthorizeUserUseCase() -> AuthorizeUserUseCase {
        DefaultAuthorizeUserUseCase(
            authorizeUserRepository: makeAuthorizeUserRepository(),
            userSessionRepository: userSessionRepository
        )
    }

    func makeSignUpUseCase() -> SignUpUseCase {
        DefaultSignUpUseCase(signUpRepository: makeSignUpRepository())
    }

    func makeVerifyIDAvailabilityUseCase() -> VerifyIDAvailabilityUseCase {
        DefaultVerifyIDAvailabilityUseCase(verifyIDAvailabilityRepository: makeVerifyIDAvailabilityRepository())
    }

    func makeUserNameUseCase() -> UserNameUseCase {
        DefaultUserNameUseCase(userSessionRepository: userSessionRepository)
    }

    func makeMyPageUseCase() -> MyPageUseCase {
        DefaultMyPageUseCase(myPageRepository: makeMyPageRepository())
    }

    func makeMapUseCase() -> MapUseCase {
        DefaultMapUseCase(mapRepository: makeMapRepository())
    }

    func makeSaveCredentialsUseCase() -> SaveCredentialsUseCase {
        DefaultSaveCredentialsUseCase(credentialsRepository: makeCredentialsRepository())
    }

    func makeFetchCredentialsUseCase() -> FetchCredentialsUseCase {
        DefaultFetchCredentialsUseCase(credentialsRepository: makeCredentialsRepository())
    }

    func makeSaveRememberSignInStatusUseCase() -> SaveRememberSignInStatusUseCase {
        DefaultSaveRememberSignInStatusUseCase(rememberSignInStatusRepository: makeRememberSignInStatusRepository())
    }

    func makeFetchRememberSignInStatusUseCase() -> FetchRememberSignInStatusUseCase {
        DefaultFetchRememberSignInStatusUseCase(rememberSignInStatusRepository: makeRememberSignInStatusRepository())
    }

    func makeSaveAutoSignInStatusUseCase() -> SaveAutoSignInStatusUseCase {
        DefaultSaveAutoSignInStatusUseCase(autoSignInStatusRepository: makeAutoSignInStatusRepository())
    }

    func makeFetchAutoSignInStatusUseCase() -> FetchAutoSignInStatusUseCase {
        DefaultFetchAutoSignInStatusUseCase(autoSignInStatusRepository: makeAutoSignInStatusRepository())
    }
}
