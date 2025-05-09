import CoreData
import CoreLocation

final class MapViewModel {
    private let mapUseCase: MapUseCase
    private let fetchKickScooterUseCase: FetchKickScooterUseCase
    private let saveReservationUseCase: SaveReservationUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    private let fetchActiveReservationUseCase: FetchActiveReservationUseCase

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
        saveReservationUseCase: SaveReservationUseCase,
        fetchAddressUseCase: FetchAddressUseCase,
        fetchActiveReservationUseCase: FetchActiveReservationUseCase
    ) {
        self.mapUseCase = mapUseCase
        self.fetchKickScooterUseCase = fetchKickScooterUseCase
        self.saveReservationUseCase = saveReservationUseCase
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchActiveReservationUseCase = fetchActiveReservationUseCase
    }

    func clearSearchResults() {
        searchResults = []
        didUpdateResults?()
    }

    func searchAddress(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            clearSearchResults()
            return
        }

        mapUseCase.excute(query: query) { [weak self] result in
            switch result {
            case let .success(address):
                self?.searchResults = address
                self?.didUpdateResults?()

            case let .failure(error):
                print("Address search fail", error.localizedDescription)
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
        fetchAddressUseCase.execute(lon: "\(kickScooter.lon)", lat: "\(kickScooter.lat)") { [weak self] result in
            if case let .success(address) = result {
                self?.saveReservationUseCase.execute(kickScooterID: kickScooter.id, address: address)
            }
        }
    }

    func hasActiveReservation() -> Bool {
        guard let hasActive = fetchActiveReservationUseCase.execute() else {
            return false
        }

        return true
    }
}
