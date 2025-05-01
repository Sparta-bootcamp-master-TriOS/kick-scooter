import Foundation
import MapKit

final class MyPageViewModel: MyPageViewModelDelegate {
    enum Action {
        case fetchUserProfile
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

    let locationManager = LocationManager.shared
    private let mapper = UserUIMapper.shared

    private(set) var userProfile: UserProfileUI?
    private(set) var currentLocation: CLLocationCoordinate2D?

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
                let userProfile = fetchUserProfile()
                self.userProfile = userProfile
                self.onStateChanged?(.userProfile(userProfile))
            }
        }
    }

    func fetchUserProfile() -> UserProfileUI {
        let id = fetchUserIDUseCase.execute()
        let user = myPageUseCase.fetchUserProfile(id)

        // delete
        var userui = mapper.map(user: user)
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
