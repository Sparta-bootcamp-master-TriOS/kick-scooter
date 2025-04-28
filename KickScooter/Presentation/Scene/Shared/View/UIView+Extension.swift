import UIKit

extension UIView {
    func shake(duration: CFTimeInterval = 0.5, values: [CGFloat] = [-10, 10, -8, 8, -5, 5, 0]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = values
        layer.add(animation, forKey: "shake")
    }
}
