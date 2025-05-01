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
        addSubview(mapView)

        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
