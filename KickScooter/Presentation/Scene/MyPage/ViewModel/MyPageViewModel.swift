import Foundation
import MapKit

final class MyPageViewModel: MyPageViewModelDelegate {
    enum Action {
        case fetchUserProfile
        case updateReservation(ReservationUI)
    }

    enum State {
        case userProfile(UserProfileUI)
    }

    var action: ((Action) -> Void)?
    var onStateChanged: ((State) -> Void)?

    private let myPageUseCase: MyPageUseCase
    private let fetchUserIDUseCase: FetchUserIDUseCase
    private let clearCredentialsUseCase: ClearCredentialsUseCase
    private let clearRememberSignInStatusUseCase: ClearRememberSignInStatusUseCase
    private let clearAutoSignInStatusUseCase: ClearAutoSignInStatusUseCase

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
        clearAutoSignInStatusUseCase: ClearAutoSignInStatusUseCase
    ) {
        self.myPageUseCase = myPageUseCase
        self.fetchUserIDUseCase = fetchUserIDUseCase
        self.clearCredentialsUseCase = clearCredentialsUseCase
        self.clearRememberSignInStatusUseCase = clearRememberSignInStatusUseCase
        self.clearAutoSignInStatusUseCase = clearAutoSignInStatusUseCase

        action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchUserProfile:
                self.userProfile = fetchUserProfile()
            case let .updateReservation(reservation):
                if updateReservation(reservation) {
                    self.userProfile = fetchUserProfile()
                }
            }
        }
    }

    private func updateReservation(_ reservation: ReservationUI) -> Bool {
        guard var latestReservation = userProfile?.reservations.first else { return false }
        latestReservation.status = reservation.status
        latestReservation.endLat = reservation.endLat
        latestReservation.endLon = reservation.endLon
        latestReservation.totalTime = Formatter.getTotalTime(from: latestReservation.date, reservation.date)
        latestReservation.kickScooter.lat = reservation.endLat
        latestReservation.kickScooter.lon = reservation.endLon
        latestReservation.kickScooter.isAvailable = reservation.kickScooter.isAvailable
        let mappedReservation = reservationMapper.map(reservation: latestReservation)

        guard let userId = userProfile?.id else { return false }
        return myPageUseCase.updateReservation(
            userId: userId,
            reservation: mappedReservation
        )
    }

    func fetchUserProfile() -> UserProfileUI {
        let id = fetchUserIDUseCase.execute()
        let user = myPageUseCase.fetchUserProfile(id)

        // delete
        var userui = userMapper.map(user: user)
        for item in mockReservationsUI {
            userui.reservations.append(item)
        }

//        return mapper.map(user: user)
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
