import Foundation

struct ReservationUI: Hashable {
    let date: Date
    var status: Bool
    let startLon: Double
    let startLat: Double
    let endLon: Double?
    let endLat: Double?
    let startAddress: String
    let endAddress: String?
    let totalTime: String?
    let totalPrice: String?
    var kickScooter: KickScooterUI
}
