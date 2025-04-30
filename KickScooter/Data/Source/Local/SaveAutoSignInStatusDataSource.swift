import Foundation

struct SaveAutoSignInStatusDataSource {
    func execute(status: Bool) {
        UserDefaults.standard.set(status, forKey: "autoSignIn")
    }
}
