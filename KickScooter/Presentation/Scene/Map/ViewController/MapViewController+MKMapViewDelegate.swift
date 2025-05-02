import MapKit

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        guard let annotation = annotation as? KickScooterAnnotation else {
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

            if let selectedAnnotation = mapView.selectedAnnotations.first {
                mapView.deselectAnnotation(selectedAnnotation, animated: true)

                mapView.removeAnnotation(selectedAnnotation)
            }
        }

        return annotationView
    }

    func mapView(_: MKMapView, didSelect view: MKAnnotationView) {
        if let calloutView = view.detailCalloutAccessoryView as? KickScooterCalloutView {
            let hasActiveReservation = mapViewModel.hasActiveReservation()
            calloutView.toggleEnabled(isEnabled: !hasActiveReservation)
        }
    }
}
