import MapKit
import SnapKit
import UIKit

final class MyPageMap: UIView {
    private let mapView = MKMapView()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false
        mapView.showsUserLocation = true
        mapView.isUserInteractionEnabled = false
        mapView.pointOfInterestFilter = .excludingAll

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
