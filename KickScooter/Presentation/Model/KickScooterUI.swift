import Foundation

struct KickScooterUI: Hashable, CoordinatesableUI {
    let id: UUID
    let battery: String
    let type: Int
    var lon: Double
    var lat: Double
    var isAvailable: Bool

    var kickScooterType: KickScooterType? {
        KickScooterType(rawValue: type)
    }
}
