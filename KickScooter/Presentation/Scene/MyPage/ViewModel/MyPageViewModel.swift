import Foundation
import MapKit

final class MyPageViewModel: MyPageViewModelDelegate {
    enum Action {
        case fetchUserProfile
        case updateReservation(ReservationUI)
    }

    enum State {
        case userProfile(UserProfileUI)
        case didUpdateReservation(UserProfileUI)
    }

    var action: ((Action) -> Void)?
    var onStateChanged: ((State) -> Void)?

    private let myPageUseCase: MyPageUseCase
    private let fetchUserIDUseCase: FetchUserIDUseCase
    private let clearCredentialsUseCase: ClearCredentialsUseCase
    private let clearRememberSignInStatusUseCase: ClearRememberSignInStatusUseCase
    private let clearAutoSignInStatusUseCase: ClearAutoSignInStatusUseCase
    private let fetchActiveReservationUseCase: FetchActiveReservationUseCase
    private let fetchAddressUseCase: FetchAddressUseCase

    private let userMapper = UserUIMapper.shared
    private let reservationMapper = ReservationUIMapper.shared

    private(set) var currentLocation: CLLocationCoordinate2D?
    private(set) var userProfile: UserProfileUI? {
        didSet {
            if let userProfile {
                onStateChanged?(.userProfile(userProfile))
            }
        }
    }

    let locationManager = LocationManager.shared
    private let mapper = UserUIMapper.shared

    init(
        myPageUseCase: MyPageUseCase,
        fetchUserIDUseCase: FetchUserIDUseCase,
        clearCredentialsUseCase: ClearCredentialsUseCase,
        clearRememberSignInStatusUseCase: ClearRememberSignInStatusUseCase,
        clearAutoSignInStatusUseCase: ClearAutoSignInStatusUseCase,
        fetchActiveReservationUseCase: FetchActiveReservationUseCase,
        fetchAddressUseCase: FetchAddressUseCase
    ) {
        self.myPageUseCase = myPageUseCase
        self.fetchUserIDUseCase = fetchUserIDUseCase
        self.clearCredentialsUseCase = clearCredentialsUseCase
        self.clearRememberSignInStatusUseCase = clearRememberSignInStatusUseCase
        self.clearAutoSignInStatusUseCase = clearAutoSignInStatusUseCase
        self.fetchActiveReservationUseCase = fetchActiveReservationUseCase
        self.fetchAddressUseCase = fetchAddressUseCase

        action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchUserProfile:
                self.userProfile = fetchUserProfile()
            case let .updateReservation(reservation):
                updateReservation(reservation)
                self.userProfile = fetchUserProfile()
            }
        }
    }

    private func updateReservation(_ reservation: ReservationUI) {
        guard let lon = currentLocation?.longitude,
              let lat = currentLocation?.latitude
        else {
            return
        }

        fetchAddressUseCase.execute(lon: "\(lon)", lat: "\(lat)") { [weak self] result in
            guard let self else { return }

            if case let .success(address) = result {
                let latestReservation = self.reservationMapper.map(
                    reservation,
                    self.currentLocation,
                    address
                )

                myPageUseCase.updateReservation(reservation: latestReservation)

                let updatedUserProfile = self.fetchUserProfile()
                self.userProfile = updatedUserProfile
                onStateChanged?(.didUpdateReservation(updatedUserProfile))
            }
        }
    }

    func fetchUserProfile() -> UserProfileUI {
        let id = fetchUserIDUseCase.execute()

        let user = myPageUseCase.fetchUserProfile(id)

        let userui = userMapper.map(user: user)

        return userui
    }

    func signOut() {
        clearCredentialsUseCase.execute()
        clearRememberSignInStatusUseCase.execute()
        clearAutoSignInStatusUseCase.execute()
    }

    func updateCurrentLocation(_ coordinate: CLLocationCoordinate2D) {
        currentLocation = coordinate
    }
}
