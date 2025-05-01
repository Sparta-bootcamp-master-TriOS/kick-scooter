struct ReservationResponseMapper {
    static let shared = ReservationResponseMapper()

    private let kickScooterMapper = KickScooterResponseMapper.shared

    func map(from entity: ReservationEntity) -> ReservationResponse {
        ReservationResponse(
            date: entity.date,
            status: entity.status,
            startLon: entity.startLon,
            startLat: entity.startLat,
            endLon: entity.endLon?.doubleValue,
            endLat: entity.endLat?.doubleValue,
            startAddress: entity.startAddress,
            endAddress: entity.endAddress,
            totalTime: entity.totalTime,
            totalPrice: entity.totalPrice,
            kickScooter: kickScooterMapper.map(from: entity.kickScooter)
        )
    }

    func map(from response: ReservationResponse) -> Reservation {
        Reservation(
            date: response.date,
            status: response.status,
            startLon: response.startLon,
            startLat: response.startLat,
            endLon: response.endLon,
            endLat: response.endLat,
            startAddress: response.startAddress,
            endAddress: response.endAddress,
            totalTime: response.totalTime,
            totalPrice: response.totalPrice,
            kickScooter: kickScooterMapper.map(from: response.kickScooter)
        )
    }
}
