import Foundation

struct SaveCredentialsDataSource {
    func execute(id: String, password: String) {
        UserDefaults.standard.set(id, forKey: "savedID")
        UserDefaults.standard.set(password, forKey: "savedPassword")
    }
}
