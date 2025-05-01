import Foundation

struct PastRidesMock: Hashable {
    let id: UUID = .init()
    let date: String
    let totalTime: String
    let start: String
    let end: String
    let scooterImg: String
    let scooterModel: String
    let priceValue: String
}

extension PastRidesMock {
    static let pastRidesMock: [PastRidesMock] = [
        PastRidesMock(
            date: "2025년 3월 22일 (월)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123",
            end: "서울시 강남구 역삼대로 4",
            scooterImg: "KickScooter1",
            scooterModel: "가성비 킥보드",
            priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 3월 10일 (수)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter3", scooterModel: "가성비 킥보드", priceValue: "25,000원"
        ),
        PastRidesMock(
            date: "2025년 3월 8일 (일)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter2", scooterModel: "가성비 킥보드", priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 1월 2일 (월)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter1", scooterModel: "가성비 킥보드", priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 3월 22일 (월)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter1", scooterModel: "가성비 킥보드", priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 3월 10일 (수)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter3", scooterModel: "비싼 킥보드", priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 3월 8일 (일)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter2", scooterModel: "비싼 킥보드", priceValue: "15,000원"
        ),
        PastRidesMock(
            date: "2025년 1월 2일 (월)",
            totalTime: "1시간 5분 3초",
            start: "서울시 강남구 역삼대로 123", end: "서울시 강남구 역삼대로 4", scooterImg: "KickScooter1", scooterModel: "가성비 킥보드", priceValue: "15,000원"
        ),
    ]
}
