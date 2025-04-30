struct ReservationUIMapper {
    static let shared = ReservationUIMapper()

    private let kickScooterMapper = KickScooterUIMapper.shared

    func map(reservations: [Reservation]) -> [ReservationUI] {
        reservations.map {
            let reservation = ReservationUI(
                date: "\($0.date)",
                status: $0.status,
                kickScooter: kickScooterMapper.map(kickScooter: $0.kickScooter)
            )
            return reservation
        }
    }
}
