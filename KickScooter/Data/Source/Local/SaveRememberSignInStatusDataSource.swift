import Foundation

struct SaveRememberSignInStatusDataSource {
    func execute(status: Bool) {
        UserDefaults.standard.set(status, forKey: "rememberAccount")
    }
}
