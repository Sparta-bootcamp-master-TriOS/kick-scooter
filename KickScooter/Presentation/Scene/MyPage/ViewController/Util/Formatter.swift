import Foundation

enum Formatter {
    static func getTotalTime(
        from startTime: Date,
        _ endTime: Date = Date()
    ) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.hour, .minute, .second],
            from: startTime,
            to: endTime
        )

        guard let hour = components.hour,
              let minute = components.minute,
              let second = components.second
        else {
            return ""
        }

        return String(format: "%02시간 %02분 %02초", hour, minute, second)
    }

    static func getFormattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
