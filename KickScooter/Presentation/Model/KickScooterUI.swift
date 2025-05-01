import Foundation

struct KickScooterUI: Hashable, CoordinatesableUI {
    let id: UUID
    let battery: String
    let type: Int
    let lon: Double
    let lat: Double
    let isAvailable: Bool
}
