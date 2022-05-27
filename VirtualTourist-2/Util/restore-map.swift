//
//  restore-map.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import Foundation
import MapKit
import CoreLocation

func restoreMap(mapView: MKMapView, centerCoordinate: CLLocationCoordinate2D) {
    let defaults = UserDefaults.standard
    if let zoomLevel = defaults.object(forKey: Key.mapZoomLevel.rawValue) as? Double
    {
        mapView.setCenter(centerCoordinate, animated: true)
        mapView.zoomLevel = zoomLevel
    }
}
