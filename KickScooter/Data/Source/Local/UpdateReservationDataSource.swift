import Foundation

final class UpdateReservationDataSource {
    private let persisrenceController: PersistenceController

    init(persisrenceController: PersistenceController) {
        self.persisrenceController = persisrenceController
    }

    /// CoreData에서 UserEntity 데이터를 가져오는 메서드
    ///
    /// - Returns:userId 로 검색한 UserEntity 결과 데이터
    func execute(userId: String, reservation: Reservation) -> Bool {
        let context = persisrenceController.context
        let cleanedID = userId.replacingOccurrences(of: "@", with: "")

        // 1. Fetch User
        guard let user = UserProfileDataSource(
            persisrenceController: persisrenceController
        ).execute(cleanedID) else {
            print("User Not Found")
            return false
        }

        // 2. User의 Reservations 중 status == true인 것만 필터
        if let reservations = user.reservations as? Set<ReservationEntity> {
            let filltered = reservations.filter { $0.status }

            // 3. 필요한 속성 업데이트
            for attribute in filltered {
                attribute.totalTime = reservation.totalTime
                attribute.totalPrice = reservation.totalPrice
                attribute.status = reservation.status
                attribute.endLat = reservation.endLat
                attribute.endLon = reservation.endLon
                attribute.endAddress = reservation.endAddress
            }

            try? context.save()
            return true
        } else {
            print("No reservations found")
            return false
        }
    }
}
