import Foundation

final class AddKickScooterViewModel {
    private let fetchUserNameUseCase: FetchUserNameUseCase
    private let saveKickScooterUseCase: SaveKickScooterUseCase

    private let locationManager = LocationManager.shared
    private let mapper = KickScooterUIMapper.shared

    private var selectedBatteryLevel: BatteryLevel = .high
    private var selectedKickScooterType: KickScooterType = .expensive

    var onBatteryChanged: ((Int) -> Void)?
    var onKickScooterTypeChanged: ((Int) -> Void)?

    init(fetchUserNameUseCase: FetchUserNameUseCase, saveKickScooterUseCase: SaveKickScooterUseCase) {
        self.fetchUserNameUseCase = fetchUserNameUseCase
        self.saveKickScooterUseCase = saveKickScooterUseCase
    }

    func greeting() -> String {
        GreetingGenerator.greetingMessage()
    }

    func user() -> String? {
        guard let user = fetchUserNameUseCase.execute() else { return nil }

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

    func saveKickScooter() {
        locationManager.requestCurrentLocation { [weak self] coordinate in
            guard let self else { return }

            let kickScooter = KickScooter(
                id: UUID(),
                battery: self.selectedBatteryLevel.desc,
                type: self.selectedKickScooterType.rawValue,
                lon: "\(coordinate.longitude)",
                lat: "\(coordinate.latitude)",
                isAvailable: true
            )

            self.saveKickScooterUseCase.execute(kickScooter: kickScooter)
        }
    }
}
