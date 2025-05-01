import MapKit

final class KickScooterAnnotationView: MKAnnotationView {
    static let identifier = "KickScooterAnnotationView"

    var onReserveTapped: ((KickScooterUI) -> Void)?

    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? KickScooterAnnotation else { return }

            canShowCallout = true
            displayPriority = .required

            if let type = annotation.kickScooter.kickScooterType, let image = UIImage(named: type.image) {
                let size = CGSize(width: 45, height: 45)
                let cornerRadius: CGFloat = 10

                let finalImage = UIGraphicsImageRenderer(size: size).image { _ in
                    let backgroundRect = CGRect(origin: .zero, size: size)
                    UIColor.white.setFill()
                    UIBezierPath(roundedRect: backgroundRect, cornerRadius: cornerRadius).fill()

                    let padding: CGFloat = 5
                    let imageRect = backgroundRect.insetBy(dx: padding, dy: padding)
                    let path = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
                    path.addClip()

                    image.draw(in: imageRect)
                }

                self.image = finalImage
                centerOffset = CGPoint(x: 0, y: -size.height / 2)
            }

            let calloutView = KickScooterCalloutView()
            calloutView.updateUI(kickScooter: annotation.kickScooter)
            calloutView.onReserveTapped = { [weak self] in
                self?.onReserveTapped?(annotation.kickScooter)
            }
            detailCalloutAccessoryView = calloutView
        }
    }
}
