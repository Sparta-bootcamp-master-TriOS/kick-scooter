import MapKit

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        guard let scooterAnnotation = annotation as? KickScooterAnnotation else {
            return nil
        }

        guard let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: KickScooterAnnotationView.identifier,
            for: annotation
        ) as? KickScooterAnnotationView else {
            return nil
        }

        annotationView.onReserveTapped = { [weak self] kickScooter in
            self?.mapViewModel.saveReservation(kickScooter: kickScooter)
        }

        return annotationView
    }
}
