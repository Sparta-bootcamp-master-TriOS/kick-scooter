import CoreData
import CoreLocation

final class MapViewModel {
    private let mapUseCase: MapUseCase
    private let fetchKickScooterUseCase: FetchKickScooterUseCase
    private let saveReservationUseCase: SaveReservationUseCase

    private let kickScooterUIMapper = KickScooterUIMapper.shared

    private(set) var searchResults: [MapResponse] = []

    var didUpdateResults: (() -> Void)?
    var didUpdateKickScooter: (([KickScooterUI]) -> Void)?

    var isScooterVisible = true

    let locationManager = LocationManager.shared
    var hasRequestedLocation = false

    init(
        mapUseCase: MapUseCase,
        fetchKickScooterUseCase: FetchKickScooterUseCase,
        saveReservationUseCase: SaveReservationUseCase
    ) {
        self.mapUseCase = mapUseCase
        self.fetchKickScooterUseCase = fetchKickScooterUseCase
        self.saveReservationUseCase = saveReservationUseCase
    }

    func searchAddress(query: String) {
        mapUseCase.excute(query: query) { [weak self] result in
            switch result {
            case let .success(address):
                self?.searchResults = address
                self?.didUpdateResults?()
            case let .failure(error):
                print("Address search fail")
            }
        }
    }

    func loadNearbyKickScooter(userCoordinate: CLLocationCoordinate2D) {
        let scooter = fetchKickScooterUseCase.execute()

        let nearbyScooter = scooter
            .filter { $0.isAvailable }
            .filter { scooter in
                let lat = scooter.lat
                let lon = scooter.lon
                let scooterLocation = CLLocation(latitude: lat, longitude: lon)
                let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)

                let distance = userLocation.distance(from: scooterLocation)
                return distance <= 1000
            }

        let uiModel = nearbyScooter.map {
            kickScooterUIMapper.map(kickScooter: $0)
        }

        didUpdateKickScooter?(uiModel)
    }

    func saveReservation(kickScooter: KickScooterUI) {
        saveReservationUseCase.execute(kickScooterID: kickScooter.id)
    }
}
