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
    /// Mock 데이터 `UserMetaEntity`를 생성한다.
    static func injectMockMyPageData(into context: NSManagedObjectContext) {
        let userMeta = makeUserMetaEntity(into: context)

        let kickScooters: [KickScooterResponse] = getKickScooterResponseMockData()

        for (index, kickScooterResponse) in kickScooters.enumerated() {
            let reservationMeta = makeReservationMetaEntity(
                into: context,
                forUser: userMeta,
                date: Date().addingTimeInterval(-86400 * Double(index)),
                status: (index == 0)
            )
            
            let kickScooterMeta = makeKickScooterMetaEntity(
                into: context,
                with: kickScooterResponse,
                forReservation: reservationMeta
            )
            
            reservationMeta.kickScooterMeta = kickScooterMeta
            userMeta.addToReservationsMeta(reservationMeta)
        }

        try? context.save()
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `ReservationMetaEntity`를 생성한다.
    static func makeReservationMetaEntity(
        into context: NSManagedObjectContext,
        forUser user: UserMetaEntity,
        date: Date,
        status: Bool
    ) -> ReservationMetaEntity {
        let reservationMeta = ReservationMetaEntity(context: context)
        reservationMeta.date = date
        reservationMeta.status = status
        reservationMeta.userMeta = user
        return reservationMeta
    }
    
    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `KickScooterMetaEntity`를 생성한다.
    static func makeKickScooterMetaEntity(
        into context: NSManagedObjectContext,
        with response: KickScooterResponse,
        forReservation reservation: ReservationMetaEntity
    ) -> KickScooterMetaEntity {
        let kickScooterMeta = KickScooterMetaEntity(context: context)
        kickScooterMeta.id = Int64(response.id)
        kickScooterMeta.model = response.model
        kickScooterMeta.battery = response.battery
        kickScooterMeta.price = Int64(response.price)
        kickScooterMeta.lon = response.lon
        kickScooterMeta.lat = response.lat
        kickScooterMeta.image = response.image
        kickScooterMeta.isAvailable = response.isAvailable
        kickScooterMeta.reservationMeta = reservation
        return kickScooterMeta
    }
    
    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `UserMetaEntity`를 생성한다.
    static func makeUserMetaEntity(into context: NSManagedObjectContext) -> UserMetaEntity {
        let userMeta = UserMetaEntity(context: context)
        let userResponse = getUserResponseMockData()
        userMeta.name = userResponse.name
        userMeta.email = userResponse.email
        userMeta.id = userResponse.id
        userMeta.password = userResponse.password
        return userMeta
    }

    /// `KickScooterResponse` Mock 데이터 생성 메서드
    static func getUserResponseMockData() -> UserResponse {
        UserResponse(
            name: "테스트 사용자",
            email: "testuser@example.com",
            id: "testuser",
            password: "mockpassword123",
            reservations: []
        )
    }
    
    /// `KickScooterResponse` Mock 데이터 생성 메서드
    static func getKickScooterResponseMockData() -> [KickScooterResponse] {
        [
            KickScooterResponse(
                id: 101,
                model: "Swift R1",
                battery: 95.0,
                price: 1200,
                lon: "127.0276",
                lat: "37.4979",
                image: "https://gyroorboard.com/cdn/shop/files/C1Proelectricscooter.jpg?v=1697686628",
                isAvailable: true
            ),
            KickScooterResponse(
                id: 102,
                model: "Swift T5",
                battery: 60.0,
                price: 1200,
                lon: "126.9780",
                lat: "37.5665",
                image: "https://boldcube.co.uk/cdn/shop/files/Purple_8216b295-a458-4d6e-a386-2a49deb448e3.jpg?v=1697373846",
                isAvailable: true
            ),
            KickScooterResponse(
                id: 103,
                model: "Swift R1",
                battery: 25.0,
                price: 1200,
                lon: "127.1025",
                lat: "37.5130",
                image: "https://gyroorboard.com/cdn/shop/files/C1Proelectricscooter.jpg?v=1697686628",
                isAvailable: true
            ),
            KickScooterResponse(
                id: 104,
                model: "Swift T5",
                battery: 75.0,
                price: 1200,
                lon: "127.0276",
                lat: "37.4979",
                image: "https://boldcube.co.uk/cdn/shop/files/Purple_8216b295-a458-4d6e-a386-2a49deb448e3.jpg?v=1697373846",
                isAvailable: false),
        ]
    }
}
