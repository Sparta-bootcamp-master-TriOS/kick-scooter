extension DIContainer {
    func makeAuthorizeUserDataSource() -> AuthorizeUserDataSource {
        AuthorizeUserDataSource(persistenceController: persistenceController)
    }

    func makeSignUpDataSource() -> SignUpDataSource {
        SignUpDataSource(persistenceController: persistenceController)
    }

    func makeVerifyIDAvailabilityDataSource() -> VerifyIDAvailabilityDataSource {
        VerifyIDAvailabilityDataSource(persistenceController: persistenceController)
    }

    func makeUserProfileDataSource() -> UserProfileDataSource {
        UserProfileDataSource(persisrenceController: persistenceController)
    }

    func makeRideHistoryDataSource() -> RideHistoryDataSource {
        RideHistoryDataSource(persisrenceController: persistenceController)
    }

    func makeSaveKickScooterDataSource() -> SaveKickScooterDataSource {
        SaveKickScooterDataSource(persistenceController: persistenceController)
    }

    func makeSaveCredentialsDataSource() -> SaveCredentialsDataSource {
        SaveCredentialsDataSource()
    }

    func makeFetchCredentialsDataSource() -> FetchCredentialsDataSource {
        FetchCredentialsDataSource()
    }

    func makeSaveRememberSignInStatusDataSource() -> SaveRememberSignInStatusDataSource {
        SaveRememberSignInStatusDataSource()
    }

    func makeFetchRememberSignInStatusDataSource() -> FetchRememberSignInStatusDataSource {
        FetchRememberSignInStatusDataSource()
    }

    func makeSaveAutoSignInStatusDataSource() -> SaveAutoSignInStatusDataSource {
        SaveAutoSignInStatusDataSource()
    }

    func makeFetchAutoSignInStatusDataSource() -> FetchAutoSignInStatusDataSource {
        FetchAutoSignInStatusDataSource()
    }

    func makeFetchKickScooterDataSource() -> FetchKickScooterDataSource {
        FetchKickScooterDataSource(persistenceController: persistenceController)
    }
}
