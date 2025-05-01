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

    func map(kickScooter: KickScooterUI) -> KickScooter {
        KickScooter(
            id: kickScooter.id,
            battery: BatteryLevel(desc: kickScooter.battery)!.desc,
            type: kickScooter.type,
            lon: kickScooter.lon,
            lat: kickScooter.lat,
            isAvailable: kickScooter.isAvailable
        )
    }
}
