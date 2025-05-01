import CoreData

extension PersistenceController {
    /// Mock 객체 생성 메서드
    static func makeInMemory() -> PersistenceController {
        let controller = PersistenceController(inMemory: true)

        injectMockMyPageData(into: controller.context)

        return controller
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `UserEntity`를 생성한다.
    static func injectMockMyPageData(into context: NSManagedObjectContext) {
        let user = makeUserEntity(into: context)

        let kickScooters: [KickScooterResponse] = getKickScooterResponseMockData()

        for (index, kickScooterResponse) in kickScooters.enumerated() {
            let reservation = makeReservationEntity(
                into: context,
                forUser: user,
                date: Date().addingTimeInterval(-86400 * Double(index)),
                status: index == 0
            )

            let kickScooter = makeKickScooterEntity(
                into: context,
                with: kickScooterResponse,
                forReservation: reservation
            )

            reservation.kickScooter = kickScooter
            user.addToReservations(reservation)
        }

        try? context.save()
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `ReservationEntity`를 생성한다.
    static func makeReservationEntity(
        into context: NSManagedObjectContext,
        forUser user: UserEntity,
        date: Date,
        status: Bool
    ) -> ReservationEntity {
        let reservation = ReservationEntity(context: context)
        reservation.date = date
        reservation.status = status
        reservation.user = user
        return reservation
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `KickScooterEntity`를 생성한다.
    static func makeKickScooterEntity(
        into context: NSManagedObjectContext,
        with response: KickScooterResponse,
        forReservation reservation: ReservationEntity
    ) -> KickScooterEntity {
        let kickScooter = KickScooterEntity(context: context)
        kickScooter.id = response.id
        kickScooter.battery = response.battery
        kickScooter.type = Int64(response.type)
        kickScooter.lon = response.lon
        kickScooter.lat = response.lat
        kickScooter.isAvailable = response.isAvailable
        kickScooter.reservation = reservation
        return kickScooter
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `UserEntity`를 생성한다.
    static func makeUserEntity(into context: NSManagedObjectContext) -> UserEntity {
        let user = UserEntity(context: context)
        let userResponse = getUserResponseMockData()
        user.name = userResponse.name
        user.email = userResponse.email
        user.id = userResponse.id
        user.password = userResponse.password
        return user
    }

    /// `KickScooterResponse` Mock 데이터 생성 메서드
    static func getUserResponseMockData() -> UserResponse {
        UserResponse(
            name: "Alina",
            email: "alinajoe@gmail.com",
            id: "joyalina25",
            password: "mockpassword123",
            reservations: []
        )
    }

    /// `KickScooterResponse` Mock 데이터 생성 메서드
    static func getKickScooterResponseMockData() -> [KickScooterResponse] {
        [
            KickScooterResponse(
                id: UUID(),
                battery: 95.0,
                type: 0,
                lon: 127.0276,
                lat: 37.4979,
                isAvailable: true
            ),
            KickScooterResponse(
                id: UUID(),
                battery: 60.0,
                type: 1,
                lon: 126.9780,
                lat: 37.5665,
                isAvailable: true
            ),
            KickScooterResponse(
                id: UUID(),
                battery: 25.0,
                type: 1,
                lon: 127.1025,
                lat: 37.5130,
                isAvailable: true
            ),
            KickScooterResponse(
                id: UUID(),
                battery: 75.0,
                type: 2,
                lon: 127.0276,
                lat: 37.4979,
                isAvailable: false
            ),
        ]
    }
}
