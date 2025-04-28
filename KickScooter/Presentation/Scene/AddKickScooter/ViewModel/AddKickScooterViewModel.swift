final class AddKickScooterViewModel {
    private var selectedBatteryLevel: BatteryLevel = .high

    var onBatterySelectionChanged: ((Int) -> Void)?

    func selectedBattery(at index: Int) {
        guard let batteryLevel = BatteryLevel(rawValue: index) else {
            return
        }

        selectedBatteryLevel = batteryLevel

        onBatterySelectionChanged?(selectedBatteryLevel.rawValue)
    }
}
