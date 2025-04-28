struct UserResponseMapper {
    static let shared = UserResponseMapper()

    private let reservationMapper = ReservationResponseMapper.shared

    func map(from entity: UserEntity) -> UserResponse {
        UserResponse(
            name: entity.name,
            email: entity.email,
            id: entity.id,
            password: entity.password,
            reservations: (entity.reservations as? Set<ReservationEntity> ?? [])
                .map { reservationMapper.map(from: $0) }
        )
    }

    func map(from response: UserResponse) -> User {
        User(
            id: response.id,
            password: response.password,
            name: response.name,
            email: response.email,
            reservations: response.reservations.map { reservationMapper.map(from: $0) }
        )
    }

    func map(from user: UserSignUp) -> UserResponse {
        UserResponse(
            name: user.name,
            email: user.email,
            id: user.id,
            password: user.password,
            reservations: []
        )
    }
}
