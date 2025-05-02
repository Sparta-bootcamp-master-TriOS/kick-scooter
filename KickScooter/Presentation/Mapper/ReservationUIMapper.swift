import MapKit

struct ReservationUIMapper {
    static let shared = ReservationUIMapper()

    private let kickScooterMapper = KickScooterUIMapper.shared

    func map(reservations: [Reservation]) -> [ReservationUI] {
        reservations.map {
            let reservation = ReservationUI(
                id: $0.id,
                date: $0.date,
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

    func map(_ reservation: ReservationUI, _ location: CLLocationCoordinate2D?, _ address: String) -> Reservation {
        Reservation(
            id: reservation.id,
            date: reservation.date,
            status: false,
            startLon: reservation.startLon,
            startLat: reservation.startLat,
            endLon: location?.longitude,
            endLat: location?.latitude,
            startAddress: reservation.startAddress,
            endAddress: address,
            totalTime: Formatter.getTotalTime(from: reservation.date),
            totalPrice: Formatter.totalPrice(
                from: reservation.date,
                price: reservation.kickScooter.kickScooterType!.priceValue
            ),
            kickScooter: kickScooterMapper.map(kickScooter: reservation.kickScooter)
        )
    }
}
