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
}
