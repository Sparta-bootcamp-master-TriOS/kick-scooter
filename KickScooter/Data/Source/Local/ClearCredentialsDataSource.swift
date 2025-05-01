import Foundation

struct ClearCredentialsDataSource {
    func execute() {
        UserDefaults.standard.removeObject(forKey: "savedID")
        UserDefaults.standard.removeObject(forKey: "savedPassword")
    }
}
