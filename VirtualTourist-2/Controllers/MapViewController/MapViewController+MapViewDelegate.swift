//
//  MapViewController+MapViewDelegate.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate  {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerCoordinate = mapView.centerCoordinate
        
        flush()
    }
    
    func flush() {
        let defaults = UserDefaults.standard
        defaults.set(centerCoordinate?.latitude, forKey: Key.mapCenterLatitude.rawValue)
        defaults.set(centerCoordinate?.longitude, forKey: Key.mapCenterLongitude.rawValue)
    }
}
