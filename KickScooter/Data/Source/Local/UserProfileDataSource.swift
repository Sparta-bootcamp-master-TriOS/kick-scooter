import Foundation

final class UserProfileDataSource {
    private let persisrenceController: PersistenceController
    
    init(persisrenceController: PersistenceController) {
        self.persisrenceController = persisrenceController
    }
    
    /// CoreData에서 가져온 UserEntity 를  UserProfile 데이터 내보내는 메서드
    ///
    /// - Returns:UserProfile
    func execute(_ userId: String) -> UserEntity? {
        guard let user = userProfile(userId) else {
            return .none
        }
        return user
    }
    
    /// CoreData에서 UserEntity 데이터를 가져오는 메서드
    ///
    /// - Returns:userId 로 검색한 UserEntity 결과 데이터
    private func userProfile(_ userId: String) -> UserEntity? {
        let context = persisrenceController.context
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", userId)
        return try? context.fetch(request).first
    }
}
