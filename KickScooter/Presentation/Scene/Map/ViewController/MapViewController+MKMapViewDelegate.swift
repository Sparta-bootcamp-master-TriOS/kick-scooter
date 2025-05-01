import MapKit

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        guard annotation is KickScooterAnnotation else {
            return nil
        }

        return mapView.dequeueReusableAnnotationView(
            withIdentifier: KickScooterAnnotationView.identifier,
            for: annotation
        )
    }
}
