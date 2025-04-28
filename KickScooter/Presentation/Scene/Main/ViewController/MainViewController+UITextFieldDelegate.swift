import UIKit

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        signInButton.sendActions(for: .touchUpInside)

        return true
    }
}
