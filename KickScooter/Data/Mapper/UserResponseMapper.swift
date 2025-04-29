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

    func map(from userEntity: UserEntity, with reservationEntity: [ReservationEntity]) -> UserProfile? {
        let reservations = reservationEntity.map {
            let kickScooter = KickScooter(
                id: Int($0.kickScooter.id),
                model: $0.kickScooter.model,
                battery: $0.kickScooter.battery,
                price: Int($0.kickScooter.price),
                lon: $0.kickScooter.lon,
                lat: $0.kickScooter.lat,
                image: $0.kickScooter.image,
                isAvailable: $0.kickScooter.isAvailable
            )

            return Reservation(
                date: $0.date,
                status: $0.status,
                kickScooter: kickScooter
            )
        }

        return UserProfile(
            name: userEntity.name,
            email: userEntity.email,
            id: userEntity.id,
            reservations: reservations
        )
    }
}
