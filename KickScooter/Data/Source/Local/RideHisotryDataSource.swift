import Foundation

final class RideHistoryDataSource {
    private let persisrenceController: PersistenceController

    init(persisrenceController: PersistenceController) {
        self.persisrenceController = persisrenceController
    }

    /// CoreData에서 UserEntity 에서 유저의 예약 히스토리를 가져오는 메서드
    ///
    /// - Returns:User의 예약 히스토리
    func execute(_ userId: String) -> [ReservationEntity]? {
        guard let reservations = reservations(for: userId) else {
            return .none
        }
        return reservations
    }

    /// CoreData에서 ReservationEntity 데이터를 가져오는 메서드
    ///
    /// - Returns:userId 로 검색한 ReservationEntity 결과 데이터
    private func reservations(for userId: String) -> [ReservationEntity]? {
        let context = persisrenceController.context
        let request = ReservationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "user.id == %@", userId)
        request.relationshipKeyPathsForPrefetching = ["kickScooter"]
        return try? context.fetch(request)
    }
}
