import CoreLocation
import UIKit

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()

        locationManager.delegate = self
    }

    func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            onLocationUpdate = completion
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            onLocationUpdate = completion
            locationManager.requestLocation()
        case .denied, .restricted:
            showPermissionAlert()
        default:
            break
        }
    }

    private func showPermissionAlert() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else { return }

        let alert = UIAlertController(
            title: "위치 권한 필요",
            message: "킥보드를 등록하려면 위치 접근 권한이 필요합니다.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let locationSettingsURL = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                UIApplication.shared.open(locationSettingsURL)
            }
        })

        root.present(alert, animated: true)
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }

        onLocationUpdate?(coordinate)
    }
}
