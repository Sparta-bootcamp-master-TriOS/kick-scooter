struct ReservationResponseMapper {
    static let shared = ReservationResponseMapper()

    private let kickScooterMapper = KickScooterResponseMapper.shared

    func map(from entity: ReservationEntity) -> ReservationResponse {
        ReservationResponse(
            date: entity.date,
            status: entity.status,
            kickScooter: kickScooterMapper.map(from: entity.kickScooter)
        )
    }

    func map(from response: ReservationResponse) -> Reservation {
        Reservation(
            date: response.date,
            status: response.status,
            kickScooter: kickScooterMapper.map(from: response.kickScooter)
        )
    }
}
