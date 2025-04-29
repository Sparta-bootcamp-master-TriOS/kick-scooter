final class DefaultMyPageUseCase: MyPageUseCase {
    
    private let myPageRepository: MyPageRepository
    
    init(myPageRepository: MyPageRepository) {
        self.myPageRepository = myPageRepository
    }
    
    func fetchUserProfile(_ userId: String) -> UserProfile? {
        guard let user =
                myPageRepository.fetchUserEntity(userId),
              let rideHistory = myPageRepository.fetchreservationEntity(for: userId)
        else {
            return .none
        }
        return myPageRepository.fetchUserProfile(
            user: user,
            rideHistory: rideHistory
        )
    }
}
