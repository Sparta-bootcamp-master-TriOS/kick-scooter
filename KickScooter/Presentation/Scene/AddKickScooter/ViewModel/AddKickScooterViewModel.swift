final class AddKickScooterViewModel {
    private let userNameUseCase: UserNameUseCase

    private var selectedBatteryLevel: BatteryLevel = .high
    private var selectedKickScooterType: KickScooterType = .expensive

    var onBatteryChanged: ((Int) -> Void)?
    var onKickScooterTypeChanged: ((Int) -> Void)?

    init(userNameUseCase: UserNameUseCase) {
        self.userNameUseCase = userNameUseCase
    }

    func greeting() -> String {
        GreetingGenerator.greetingMessage()
    }

    func user() -> String? {
        guard let user = userNameUseCase.execute() else { return nil }

        return user.name
    }

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
