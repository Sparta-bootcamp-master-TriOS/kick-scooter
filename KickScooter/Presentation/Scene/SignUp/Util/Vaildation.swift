import UIKit

struct ValidationItem {
    let textField: UITextField
    let label: InvalidLabel
    let validation: (String) -> Bool
}
