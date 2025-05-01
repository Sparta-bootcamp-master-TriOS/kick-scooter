import Foundation

struct ReservationUI: Hashable {
    let date: Date
    let status: Bool
    let startLon: Double
    let startLat: Double
    let endLon: Double?
    let endLat: Double?
    let startAddress: String
    let endAddress: String?
    let totalTime: String?
    let totalPrice: String?
    let kickScooter: KickScooterUI
}
