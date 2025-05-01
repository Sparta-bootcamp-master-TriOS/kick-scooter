import MapKit
import ObjectiveC

final class KickScooterAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let kickScooter: KickScooterUI

    init(coordinate: CLLocationCoordinate2D, kickScooter: KickScooterUI) {
        self.coordinate = coordinate
        self.kickScooter = kickScooter
    }
}
