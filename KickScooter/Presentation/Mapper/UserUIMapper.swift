struct UserUIMapper {
    static let shared = UserUIMapper()

    private let reservationMapper = ReservationUIMapper.shared

    func map(user: UserSignInUI) -> UserSignIn {
        UserSignIn(id: user.id, password: user.password)
    }

    func map(user: UserSignUpUI) -> UserSignUp {
        UserSignUp(
            name: user.name,
            email: user.email,
            id: user.id,
            password: user.password
        )
    }

    func map(user: UserProfile?) -> UserProfileUI {
        guard let user = user else {
            return UserProfileUI(
                name: "Default Name",
                email: "Default Email",
                id: "Default ID",
                reservations: []
            )
        }
        return UserProfileUI(
            name: "Hey, \(user.name)!",
            email: user.email,
            id: "@\(user.id)",
            reservations: reservationMapper.map(reservations: user.reservations)
        )
    }
}
