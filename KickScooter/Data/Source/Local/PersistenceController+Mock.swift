import CoreData

extension PersistenceController {
    /// Mock 객체 생성 메서드
    static func makeInMemory() -> PersistenceController {
        let controller = PersistenceController(inMemory: true)

        return controller
    }

    /// Mock 데이터 삽입 메서드
    ///
    /// Mock 데이터 `UserMetaEntity`를 생성한다.
    static func injectMockMyPageUserData(into context: NSManagedObjectContext) {
        let userMeta = UserMetaEntity(context: context)
        userMeta.id = "testuser"
        userMeta.email = "testuser@example.com"
        userMeta.name = "테스트 사용자"
        userMeta.password = "mockpassword123"

        let kickScooters: [KickScooterResponse] = getKickScooterResponseMockData()

        for (index, kickScooter) in kickScooters.enumerated() {
            let reservationsMeta = ReservationMetaEntity(context: context)
            reservationsMeta.date = Date().addingTimeInterval(-86400 * Double(index))
            reservationsMeta.status = (index == 0)
            reservationsMeta.userMeta = userMeta

            let kickScooterMeta = KickScooterMetaEntity(context: context)
            kickScooterMeta.id = Int64(kickScooter.id)
            kickScooterMeta.model = kickScooter.model
            kickScooterMeta.battery = kickScooter.battery
            kickScooterMeta.price = Int64(kickScooter.price)
            kickScooterMeta.lon = kickScooter.lon
            kickScooterMeta.lat = kickScooter.lat
            kickScooterMeta.image = kickScooter.image
            kickScooterMeta.isAvailable = kickScooter.isAvailable

            reservationsMeta.kickScooterMeta = kickScooterMeta
            kickScooterMeta.reservationMeta = reservationsMeta

            userMeta.addToReservationsMeta(reservationsMeta)
        }

        try? context.save()
    }

    static func getKickScooterResponseMockData() -> [KickScooterResponse] {
        let kickScooters: [KickScooterResponse] = [
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
                isAvailable: false
            ),
        ]
        return kickScooters
    }
}
