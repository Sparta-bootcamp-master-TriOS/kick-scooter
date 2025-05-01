import MapKit
import SnapKit
import UIKit

final class MapBaseView: UIView {
    let mapView = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll

        mapView.register(
            KickScooterAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: KickScooterAnnotationView.identifier
        )

        addSubview(mapView)

        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func locateCurrentCoordinate(_ coordinate: CLLocationCoordinate2D, zoomLevel: Double = 0.01) {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
        )

        mapView.setRegion(region, animated: true)
    }
}
