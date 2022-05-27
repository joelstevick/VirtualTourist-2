//
//  restore-map.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/27/22.
//

import Foundation
import MapKit
import CoreLocation

func restoreMap(mapView: MKMapView) {
    let defaults = UserDefaults.standard
    if let latitude = defaults.object(forKey: Key.mapCenterLatitude.rawValue) as? Double,
       let longitude = defaults.object(forKey: Key.mapCenterLongitude.rawValue) as? Double,
       let zoomLevel = defaults.object(forKey: Key.mapZoomLevel.rawValue) as? Double
    {
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        mapView.zoomLevel = zoomLevel
    }
}
