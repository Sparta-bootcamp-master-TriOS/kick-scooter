import Foundation

final class DefaultMyPageRepository: MyPageRepository {
    private let userProfileDataSource: UserProfileDataSource
    private let rideHistoryDataSource: RideHistoryDataSource
    private let updateReservationDataSource: UpdateReservationDataSource

    private let mapper = UserResponseMapper.shared

    init(
        userProfileDataSource: UserProfileDataSource,
        rideHistoryDataSource: RideHistoryDataSource,
        updateReservationDataSource: UpdateReservationDataSource
    ) {
        self.userProfileDataSource = userProfileDataSource
        self.rideHistoryDataSource = rideHistoryDataSource
        self.updateReservationDataSource = updateReservationDataSource
    }

    func fetchUserEntity(_ userId: String) -> UserEntity? {
        guard let user = userProfileDataSource.execute(userId) else {
            return .none
        }
        return user
    }

    func fetchreservationEntity(for userId: String) -> [ReservationEntity]? {
        guard let reservations = rideHistoryDataSource.execute(userId) else {
            return .none
        }
        return reservations
    }

    func fetchUserProfile(
        user: UserEntity,
        rideHistory: [ReservationEntity]
    ) -> UserProfile? {
        mapper.map(from: user, with: rideHistory)
    }

    func updateReservation(reservation: Reservation) {
        updateReservationDataSource.execute(reservation: reservation)
    }
}
