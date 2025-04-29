import UIKit

final class AddKickScooterBackgroundView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let colors = [UIColor.triOSMainPurple.cgColor, UIColor.triOSMainBlack.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let locations: [CGFloat] = [0.75, 0.24]

        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else {
            return
        }

        let startPoint = CGPoint(x: rect.width, y: rect.midY)
        let endPoint = CGPoint(x: 0, y: rect.midY)

        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
    }
}
