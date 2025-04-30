import Foundation

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

    private let mapper = UserUIMapper.shared

    private(set) var userProfile: UserProfileUI?

    init(
        myPageUseCase: MyPageUseCase
    ) {
        self.myPageUseCase = myPageUseCase

        action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchUserProfile:
                let userProfile = self.fetchUserProfile()
                self.userProfile = userProfile
                self.onStateChanged?(.userProfile(userProfile))
            }
        }
    }

    func fetchUserProfile() -> UserProfileUI {
        mapper.map(
            user: myPageUseCase.fetchUserProfile("joyalina25")
        )
    }
}
