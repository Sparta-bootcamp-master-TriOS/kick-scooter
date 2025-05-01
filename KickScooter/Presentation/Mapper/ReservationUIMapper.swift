struct ReservationUIMapper {
    static let shared = ReservationUIMapper()

    private let kickScooterMapper = KickScooterUIMapper.shared

    func map(reservations: [Reservation]) -> [ReservationUI] {
        reservations.map {
            let reservation = ReservationUI(
                date: "\($0.date)",
                status: $0.status,
                startLon: $0.startLon,
                startLat: $0.startLat,
                endLon: $0.endLon,
                endLat: $0.endLat,
                startAddress: $0.startAddress,
                endAddress: $0.endAddress,
                totalTime: $0.totalTime,
                totalPrice: $0.totalPrice,
                kickScooter: kickScooterMapper.map(kickScooter: $0.kickScooter)
            )
            return reservation
        }
    }
}
