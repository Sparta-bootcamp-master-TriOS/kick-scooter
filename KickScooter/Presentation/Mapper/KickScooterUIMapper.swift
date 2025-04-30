struct KickScooterUIMapper {
    static let shared = KickScooterUIMapper()

    func map(kickScooter: KickScooter) -> KickScooterUI {
        KickScooterUI(
            id: kickScooter.id,
            battery: "\(kickScooter.battery)",
            type: kickScooter.type,
            lon: kickScooter.lon,
            lat: kickScooter.lat,
            isAvailable: kickScooter.isAvailable
        )
    }
}
