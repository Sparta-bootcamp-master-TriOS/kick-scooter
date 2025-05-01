import CoreData
import CoreLocation

final class MapViewModel {
    private let mapUseCase: MapUseCase
    private let fetchKickScooterUseCase: FetchKickScooterUseCase
    private let kickScooterUIMapper = KickScooterUIMapper.shared

    private(set) var searchResults: [MapResponse] = []

    var didUpdateResults: (() -> Void)?
    var didUpdateKickScooter: (([KickScooterUI]) -> Void)?

    let locationManager = LocationManager.shared
    var hasRequestedLocation = false

    init(mapUseCase: MapUseCase, fetchKickScooterUseCase: FetchKickScooterUseCase) {
        self.mapUseCase = mapUseCase
        self.fetchKickScooterUseCase = fetchKickScooterUseCase
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

        let nearbyScooter = scooter.filter { scooter in
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
}
