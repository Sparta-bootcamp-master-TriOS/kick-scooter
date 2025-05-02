import CoreLocation
import UIKit

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func requestCurrentLocation(
        onAuthorized: @escaping (CLLocationCoordinate2D) -> Void,
        onDenied: @escaping () -> Void
    ) {
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            onLocationUpdate = onAuthorized
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            onLocationUpdate = onAuthorized
            locationManager.requestLocation()
        case .denied, .restricted:
            onDenied()
        default:
            break
        }
    }

    func startTrackingLocation(onUpdate: @escaping (CLLocationCoordinate2D) -> Void) {
        let status = locationManager.authorizationStatus

        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            onLocationUpdate = onUpdate
            locationManager.startUpdatingLocation()
        case .notDetermined:
            onLocationUpdate = onUpdate
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            break
        default:
            break
        }
    }

    func stopTrackingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }

        onLocationUpdate?(coordinate)
    }

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {}
}
