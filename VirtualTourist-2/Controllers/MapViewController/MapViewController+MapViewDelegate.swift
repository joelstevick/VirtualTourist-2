//
//  MapViewController+MapViewDelegate.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import Foundation
import MapKit
import MKZoomLevel

extension MapViewController: MKMapViewDelegate  {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerCoordinate = mapView.centerCoordinate
        
        flush()
    }
    
    func flush() {
        let defaults = UserDefaults.standard
        defaults.set(centerCoordinate?.latitude, forKey: Key.mapCenterLatitude.rawValue)
        defaults.set(centerCoordinate?.longitude, forKey: Key.mapCenterLongitude.rawValue)
        defaults.set(mapView.zoomLevel, forKey: Key.mapZoomLevel.rawValue)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        navigateToMapDetailView(view: view)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil // ignore current user location
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}
