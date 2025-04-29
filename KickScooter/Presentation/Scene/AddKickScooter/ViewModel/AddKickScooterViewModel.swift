final class AddKickScooterViewModel {
    private var selectedBatteryLevel: BatteryLevel = .high
    private var selectedKickScooterType: KickScooterType = .expensive

    var onBatteryChanged: ((Int) -> Void)?
    var onKickScooterTypeChanged: ((Int) -> Void)?

    func selectedBattery(at index: Int) {
        guard let batteryLevel = BatteryLevel(rawValue: index) else {
            return
        }

        selectedBatteryLevel = batteryLevel

        onBatteryChanged?(selectedBatteryLevel.rawValue)
    }

    func selectedKickScooter(at index: Int) {
        guard let kickScooterType = KickScooterType(rawValue: index) else {
            return
        }

        selectedKickScooterType = kickScooterType

        onKickScooterTypeChanged?(selectedKickScooterType.rawValue)
    }
}
