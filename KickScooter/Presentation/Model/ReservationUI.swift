import Foundation

struct ReservationUI: Hashable {
    let date: Date
    var status: Bool
    let startLon: Double
    let startLat: Double
    var endLon: Double
    var endLat: Double
    let startAddress: String
    var endAddress: String
    var totalTime: String
    var totalPrice: String
    var kickScooter: KickScooterUI
}
