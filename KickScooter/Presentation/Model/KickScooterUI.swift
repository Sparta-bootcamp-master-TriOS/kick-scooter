import Foundation

struct KickScooterUI: Hashable, CoordinatesableUI {
    let id: UUID
    let battery: String
    let type: Int
    let lon: String
    let lat: String
    let isAvailable: Bool
}
