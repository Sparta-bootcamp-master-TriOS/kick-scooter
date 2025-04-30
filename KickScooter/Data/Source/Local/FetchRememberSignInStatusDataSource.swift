import Foundation

struct FetchRememberSignInStatusDataSource {
    func execute() -> Bool {
        UserDefaults.standard.bool(forKey: "rememberAccount")
    }
}
