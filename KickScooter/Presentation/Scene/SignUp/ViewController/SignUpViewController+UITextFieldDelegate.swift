import UIKit

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        signUpButton.sendActions(for: .touchUpInside)

        return true
    }
}
