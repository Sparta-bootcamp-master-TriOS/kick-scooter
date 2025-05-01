import Foundation

let mockReservationsUI: [ReservationUI] = [
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 22).date!,
        status: false,
        startLon: 127.0351, startLat: 37.5010,
        endLon: 127.0287, endLat: 37.4994,
        startAddress: "서울시 강남구 역삼대로 123",
        endAddress: "서울시 강남구 역삼대로 4",
        totalTime: "1시간 5분 3초",
        totalPrice: "15,000원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "50", type: 1,
            lon: 127.0351, lat: 37.5010,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 23).date!,
        status: false,
        startLon: 126.9780, startLat: 37.5665,
        endLon: 126.9900, endLat: 37.5700,
        startAddress: "서울시 중구 세종대로 1",
        endAddress: "서울시 종로구 종로 100",
        totalTime: "45분 12초",
        totalPrice: "9,000원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "100", type: 0,
            lon: 126.9780, lat: 37.5665,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 24).date!,
        status: false,
        startLon: 127.0600, startLat: 37.5100,
        endLon: 127.0650, endLat: 37.5150,
        startAddress: "서울시 송파구 올림픽로 300",
        endAddress: "서울시 송파구 백제고분로 45",
        totalTime: "30분 8초",
        totalPrice: "7,000원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "50", type: 2,
            lon: 127.0600, lat: 37.5100,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 25).date!,
        status: false,
        startLon: 126.9950, startLat: 37.5700,
        endLon: 127.0000, endLat: 37.5730,
        startAddress: "서울시 종로구 종로1길 10",
        endAddress: "서울시 종로구 율곡로 50",
        totalTime: "20분 15초",
        totalPrice: "5,000원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "25", type: 1,
            lon: 126.9950, lat: 37.5700,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 26).date!,
        status: false,
        startLon: 127.0300, startLat: 37.5200,
        endLon: 127.0350, endLat: 37.5250,
        startAddress: "서울시 강남구 도산대로 45",
        endAddress: "서울시 강남구 학동로 12",
        totalTime: "1시간 2분 48초",
        totalPrice: "13,500원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "25", type: 0,
            lon: 127.0300, lat: 37.5200,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 29).date!,
        status: true,
        startLon: 127.0100, startLat: 37.5650,
        endLon: 127.0150, endLat: 37.5700,
        startAddress: "서울시 중구 충무로 1",
        endAddress: "서울시 중구 필동로 3길",
        totalTime: "29분 59초",
        totalPrice: "6,800원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "50", type: 0,
            lon: 127.0100, lat: 37.5650,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 27).date!,
        status: false,
        startLon: 127.0450, startLat: 37.5080,
        endLon: 127.0500, endLat: 37.5120,
        startAddress: "서울시 서초구 반포대로 87",
        endAddress: "서울시 서초구 서초대로 200",
        totalTime: "38분 10초",
        totalPrice: "8,500원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "50", type: 1,
            lon: 127.0450, lat: 37.5080,
            isAvailable: false
        )
    ),
    ReservationUI(
        date: DateComponents(calendar: .current, year: 2025, month: 3, day: 28).date!,
        status: false,
        startLon: 127.0230, startLat: 37.5500,
        endLon: 127.0300, endLat: 37.5520,
        startAddress: "서울시 성동구 왕십리로 222",
        endAddress: "서울시 성동구 행당로 100",
        totalTime: "52분 33초",
        totalPrice: "11,000원",
        kickScooter: KickScooterUI(
            id: UUID(), battery: "100", type: 2,
            lon: 127.0230, lat: 37.5500,
            isAvailable: false
        )
    ),
]
