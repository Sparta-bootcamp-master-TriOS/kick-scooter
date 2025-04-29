final class MapViewModel {
    private let mapUseCase: MapUseCase

    private(set) var searchResults: [MapResponse] = []

    var didUpdateResults: (() -> Void)?

    init(mapUseCase: MapUseCase) {
        self.mapUseCase = mapUseCase
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
}
